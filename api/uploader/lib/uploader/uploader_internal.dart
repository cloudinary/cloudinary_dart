import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_dart_uploader/src/http/extensions/list_extension.dart';
import 'package:cloudinary_dart_uploader/uploader/uploader.dart';
import 'package:cloudinary_dart_uploader/uploader/uploader_response.dart';
import 'package:cloudinary_dart_uploader/uploader/utils.dart';
import 'package:cloudinary_dart_url_gen/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../src/request/model/shared_params.dart';
import '../src/request/network_request.dart';
import '../src/request/payload.dart';
import '../src/request/upload_request.dart';
import '../src/response/upload_error.dart';
import '../src/response/upload_result.dart';
import 'abstract_uploader_request.dart';

extension UploaderInternal on Uploader {
  NetworkRequest _prepareNetworkRequest(
      String action, AbstractUploaderRequest request, SharedParams? options) {
    var config = cloudinary.config.cloudConfig;
    var prefix = cloudinary.config.apiConfig.uploadPrefix;
    var cloudName = cloudinary.config.cloudConfig.cloudName;
    var resourceType = options?.resourceType ?? defaultResourceType;

    Map<String, dynamic> paramsMap = request.buildParams();

    if (_requireSigning(action, options, paramsMap['signature'])) {
      if (config.apiKey == null) {
        ArgumentError("Must supply api_secret");
      }
      if (paramsMap['signature'] == null) {
        paramsMap['timestamp'] =
            (DateTime.now().millisecondsSinceEpoch / 1000).toString();
        paramsMap['signature'] =
            Utils.apiSignRequest(paramsMap, config.apiSecret!);
        paramsMap['api_key'] = config.apiKey;
      }
    }

    var url = [prefix, apiVersion, cloudName, resourceType, action]
        .noNullList()
        .join("/");

    return NetworkRequest(
        url,
        options?.filename,
        options?.extraHeaders ?? <String, String>{},
        paramsMap,
        (options?.timeout) ?? defaultTimeout,
        request.payload,
        request.progress,
        request.completionCallback);
  }

  Future<UploaderResponse<UploadResult>> callApi(
      AbstractUploaderRequest request, String action,
      {SharedParams? options}) async {
    try {
      var response = await networkDelegate
          .callApi(_prepareNetworkRequest(action, request, options));
      return _processResponse(response);
    } on TimeoutException catch (error) {
      return UploaderResponse(
          -1, null, UploadError('Timeout of ${error.duration} occurred'), error.message);
    }
  }

  Future<UploaderResponse<UploadResult>>? performUpload(UploadRequest request) {
    if (request.payload == null) {
      throw ArgumentError('An upload request must have a payload');
    }
    var payload = request.payload!;
    var value = payload.value;
    var chunkSize = request.uploader.cloudinary.config.apiConfig.chunkSize;
    SharedParams options = SharedParams(
        resourceType: request.params?.resourceType,
        unsigned: request.params?.unsigned,
        filename: request.params?.filename,
        timeout: request.params?.timeout,
        extraHeaders: request.params?.extraHeaders);
    if (value is String && Utils.isRemoteUrl(value) ||
        (1 > payload.length || payload.length < chunkSize!)) {
      // need to make sure if we have length or not.
      return callApi(request, 'upload', options: options);
    }
    //Upload large
    var uniqueUploadId = Utils.createRandomUploadId(8);
    _uploadLargeParts(payload, request, uniqueUploadId);
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
      Payload payload, UploadRequest request, String uniqueUploadId) async {
    late UploaderResponse<UploadResult> response;
    int chunkSize = cloudinary.config.apiConfig.chunkSize!;
    request.params?.extraHeaders = <String, String>{};
    request.params?.extraHeaders
        ?.addEntries({'X-Unique-Upload-Id': uniqueUploadId}.entries);
    int chunkCount = (payload.length / chunkSize).ceil();

    for (int index = 0; index < chunkCount; index++) {
      await _buildStreamRequest(index, chunkSize, payload, request);
    }
  }

  Future<http.StreamedResponse?>? _buildStreamRequest(
      int index, int chunkSize, Payload payload, UploadRequest request) async {
    final startOffset = _getStartOffset(index, chunkSize);
    final endOffset = _getEndOffset(index, chunkSize, payload.length);
    final stream = _getStream(startOffset, endOffset, payload);
    SharedParams options = SharedParams(
        resourceType: request.params?.resourceType,
        unsigned: request.params?.unsigned,
        filename: request.params?.filename ?? payload.name,
        timeout: request.params?.timeout ??
            request.uploader.cloudinary.config.apiConfig.timeout,
        extraHeaders: request.params?.extraHeaders);
    try {
      var requestResponse = await networkDelegate.uploadLarge(
          stream,
          _prepareNetworkRequest('upload', request, options),
          startOffset,
          endOffset,
          payload.length);
      if (request.completionCallback != null) {
        _processResponseWithCompletion(requestResponse, (response) {
          if (response.data?.done == true || response.error != null) {
            request.completionCallback!(response);
          }
        });
      }
      return requestResponse;
    } on TimeoutException catch (error) {
      request.completionCallback!(UploaderResponse(
          -1, null, UploadError('Timeout of ${error.duration} occurred'), error.message));
    }
    return null;
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
      String action, SharedParams? options, String? signature) {
    var missingSignature = (signature != null) ? false : true;
    var signedRequest =
        ((options?.unsigned != null) ? !options!.unsigned! : false);
    var actionRequiresSigning = action != 'delete_by_token';
    return missingSignature && signedRequest && actionRequiresSigning;
  }

  //Response handler
  Future<UploaderResponse<UploadResult>> _processResponse(
      StreamedResponse? requestResponse) {
    return _getProcessedResponse(requestResponse!.statusCode,
        requestResponse.stream, requestResponse.headers['x-cld-error']);
  }

  void _processResponseWithCompletion(StreamedResponse? requestResponse,
      void Function(UploaderResponse<UploadResult> response) completion) {
    var response = _getProcessedResponse(requestResponse!.statusCode,
        requestResponse.stream, requestResponse.headers['x-cld-error']);
    response.then((unwrappedResponse) {
      completion(unwrappedResponse);
    });
  }

  Future<UploaderResponse<UploadResult>> _getProcessedResponse(
      int statusCode, ByteStream? stream, String? errorHeader) async {
    var body = await stream?.transform(utf8.decoder).join();
    if (statusCode >= 200 && statusCode <= 299) {
      if (body != null) {
        final parsedJson = jsonDecode(body);
        final uploadResult = UploadResult.fromJson(parsedJson);
        return UploaderResponse<UploadResult>(
            statusCode, uploadResult, null, body);
      } else {
        var responseError = UploadError("Error");
        return UploaderResponse(statusCode, null, responseError, body);
      }
    } else if (statusCode >= 400 && statusCode < 499) {
      return UploaderResponse(
          statusCode, null, UploadError(errorHeader ?? "Unknown Error"), body);
    } else if (statusCode >= 500 && statusCode < 599) {
      return UploaderResponse(
          statusCode,
          null,
          UploadError(
              errorHeader ?? "We had an problem, please contact support"),
          body);
    }
    return UploaderResponse(
        statusCode, null, UploadError(errorHeader ?? "Unknown Error"), body);
  }
}
