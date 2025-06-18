import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_api/src/http/extensions/list_extension.dart';
import 'package:cloudinary_api/uploader/uploader_response.dart';
import 'package:cloudinary_api/uploader/utils.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_url_gen/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../src/http/session/network_delegate.dart';
import '../src/request/model/uploader_params.dart';
import '../src/request/network_request.dart';
import '../src/request/payload.dart';
import '../src/request/upload_request.dart';
import '../src/response/upload_error.dart';
import '../src/response/upload_result.dart';
import 'abstract_uploader_request.dart';

class UploaderUtils {
  final Cloudinary cloudinary;
  final networkDelegate = NetworkDelegate();

  UploaderUtils(this.cloudinary);

  NetworkRequest _prepareNetworkRequest(
      String action, AbstractUploaderRequest request, UploaderParams? options) {
    var config = cloudinary.config.cloudConfig;
    var prefix = cloudinary.config.apiConfig.uploadPrefix;
    var cloudName = cloudinary.config.cloudConfig.cloudName;
    var version = apiVersion;
    var resourceType = defaultResourceType;
    String filename = (request.params is UploadParams
        ? (request.params as UploadParams).filename
        : null) ??
        request.payload?.path ??
        request.payload?.name ??
        'file';
    if (options is UploadAssetParams) {
      resourceType = options.resourceType;
    }
    if (request.params is UploadParams &&
        (request.params as UploadParams).filename != null &&
        request.payload != null) {
      request.payload?.name = (request.params as UploadParams).filename!;
    }

    Map<String, dynamic> paramsMap = request.buildParams();

    if (_requireSigning(action, options, paramsMap['signature'])) {
      if (config.apiKey == null) {
        ArgumentError("Must supply api_secret");
      }
      if (paramsMap['signature'] == null) {
        paramsMap['timestamp'] =
            (DateTime.now().millisecondsSinceEpoch / 1000).toString();
        paramsMap['signature'] =
            Utils.apiSignRequest(paramsMap, config.apiSecret!, signatureVersion: cloudinary.config.cloudConfig.signatureVersion);
        paramsMap['api_key'] = config.apiKey;
        if (paramsMap['unsigned'] != null) {
          paramsMap.remove('unsigned');
        }
      }
    }

    if (paramsMap['api_key'] == null && (config.apiKey?.isNotEmpty ?? false)) {
      // Handles the scenario where the signature is specified explicitly.
      if (paramsMap['signature'] != null) paramsMap['api_key'] = config.apiKey;
    }

    var url = [prefix, version, cloudName, resourceType, action]
        .noNullList()
        .join("/");

    return NetworkRequest(
      url,
      options?.extraHeaders ?? <String, String>{},
      paramsMap,
      options?.timeout ?? defaultTimeout,
      filename,
      request.payload,
      request.progress,
      request.completionCallback,
    );
  }

  Future<UploaderResponse<T>> callApi<T extends BaseUploadResult>(
      AbstractUploaderRequest request, String action,
      {UploaderParams? options,
      required T Function(Map<String, dynamic> data) fromJson}) async {
    try {
      var response = await networkDelegate
          .callApi(_prepareNetworkRequest(action, request, options));
      return _processResponse<T>(response, fromJson: fromJson);
    } on TimeoutException catch (error) {
      return UploaderResponse<T>(-1, null,
          UploadError('Timeout of ${error.duration} occurred'), error.message);
    }
  }

  Future<UploaderResponse<UploadResult>>? performUpload(UploadRequest request,
      {required UploadResult Function(Map<String, dynamic> data) fromJson}) {
    if (request.payload == null) {
      throw ArgumentError('An upload request must have a payload');
    }
    var payload = request.payload!;
    var chunkSize = cloudinary.config.apiConfig.chunkSize;
    final uploadParams = request.params as UploadParams?;

    if (payload.value is String && Utils.isRemoteUrl(payload.value) ||
        (1 > payload.length || payload.length < chunkSize!)) {
      // Ensure correct type for `fromJson` when calling `callApi`
      return callApi(
        request,
        'upload',
        options: uploadParams,
        fromJson: fromJson,
      );
    }

    var uniqueUploadId = Utils.createRandomUploadId(8);
    _uploadLargeParts(payload, request, uniqueUploadId, fromJson: fromJson);
    return null;
  }

  Payload buildPayload(dynamic file) {
    if (file is File) {
      return FilePayload(file);
    } else if (file is String) {
      // check if base 64
      return DataPayload(file);
    } else if (file is Stream) {
      return StreamPayload(file);
    }
    throw ArgumentError("Current file type is not supported");
  }

  void _uploadLargeParts(
      Payload payload, UploadRequest request, String uniqueUploadId,
      {required UploadResult Function(Map<String, dynamic> data)
          fromJson}) async {
    int chunkSize = cloudinary.config.apiConfig.chunkSize!;
    request.params?.extraHeaders = <String, String>{};
    request.params?.extraHeaders
        ?.addEntries({'X-Unique-Upload-Id': uniqueUploadId}.entries);
    int chunkCount = (payload.length / chunkSize).ceil();

    for (int index = 0; index < chunkCount; index++) {
      await _buildStreamRequest(index, chunkSize, payload, request,
          fromJson: fromJson);
    }
  }

  Future<http.StreamedResponse?>? _buildStreamRequest(
      int index, int chunkSize, Payload payload, UploadRequest request,
      {required UploadResult Function(Map<String, dynamic> data)
          fromJson}) async {
    final startOffset = _getStartOffset(index, chunkSize);
    final endOffset = _getEndOffset(index, chunkSize, payload.length);
    final stream = _getStream(startOffset, endOffset, payload);
    try {
      var requestResponse = await networkDelegate.uploadLarge(
          stream,
          _prepareNetworkRequest('upload', request, request.params),
          startOffset,
          endOffset,
          payload.length);

      if (request.completionCallback != null) {
        _processResponseWithCompletion<UploadResult>(requestResponse,
            (response) {
          if (response.data?.done == true || response.error != null) {
            request.completionCallback!(response);
          }
        }, fromJson: fromJson);
      }
      return requestResponse;
    } on TimeoutException catch (error) {
      if (request.completionCallback != null) {
        request.completionCallback!(UploaderResponse<UploadResult>(
            -1,
            null,
            UploadError('Timeout of ${error.duration} occurred'),
            error.message));
      }
      return null;
    }
  }

  int _getStartOffset(int index, int chunkSize) {
    return index * chunkSize;
  }

  int _getEndOffset(int index, int chunkSize, int fileSize) {
    return min((index + 1) * chunkSize, fileSize);
  }

  Stream<List<int>> _getStream(int start, int end, Payload payload) {
    return (payload as FilePayload).value.openRead(start, end);
  }

  bool _requireSigning(
      String action, UploaderParams? options, String? signature) {
    var missingSignature = (signature != null) ? false : true;
    var signedRequest = options?.unsigned == null ||
        ((options?.unsigned != null) ? !options!.unsigned! : false);
    var actionRequiresSigning = action != 'delete_by_token';
    return missingSignature && signedRequest && actionRequiresSigning;
  }

  //Response handler
  Future<UploaderResponse<T>> _processResponse<T extends BaseUploadResult>(
      http.StreamedResponse requestResponse,
      {required Function(Map<String, dynamic> data) fromJson}) async {
    return _getProcessedResponse(requestResponse.statusCode,
        requestResponse.stream, requestResponse.headers['x-cld-error'],
        fromJson: fromJson);
  }

  void _processResponseWithCompletion<T extends BaseUploadResult>(
      StreamedResponse? requestResponse,
      void Function(UploaderResponse<T> response) completion,
      {required Function(Map<String, dynamic> data) fromJson}) {
    var response = _getProcessedResponse<T>(requestResponse!.statusCode,
        requestResponse.stream, requestResponse.headers['x-cld-error'],
        fromJson: fromJson);
    response.then((unwrappedResponse) {
      completion(unwrappedResponse);
    });
  }

  Future<UploaderResponse<T>> _getProcessedResponse<T extends BaseUploadResult>(
      int statusCode, ByteStream? stream, String? errorHeader,
      {required Function(Map<String, dynamic> data) fromJson}) async {
    var body = await stream?.transform(utf8.decoder).join();
    if (statusCode >= 200 && statusCode <= 299) {
      if (body != null) {
        final parsedJson = jsonDecode(body);
        final uploadResult = fromJson(parsedJson);
        return UploaderResponse<T>(statusCode, uploadResult, null, body);
      } else {
        var responseError = UploadError("Error");
        return UploaderResponse<T>(statusCode, null, responseError, body);
      }
    } else if (statusCode >= 400 && statusCode < 499) {
      return UploaderResponse<T>(
          statusCode, null, UploadError(errorHeader ?? "Unknown Error"), body);
    } else if (statusCode >= 500 && statusCode < 599) {
      return UploaderResponse<T>(
          statusCode,
          null,
          UploadError(
              errorHeader ?? "We had a problem, please contact support"),
          body);
    }
    return UploaderResponse<T>(
        statusCode, null, UploadError(errorHeader ?? "Unknown Error"), body);
  }

  String? getFilenameIfUploadParams(dynamic params) {
    if (params is UploadParams) {
      return params.filename;
    }
    return null;
  }

  String? getResourceTypeIfUploadAssetParams(dynamic params) {
    if (params is UploadAssetParams) {
      return params.resourceType;
    }
    return null;
  }
}
