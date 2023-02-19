import 'dart:math';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_dart/src/http/extensions/list_extension.dart';
import 'package:cloudinary_dart/uploader/abstract_uploader_request.dart';
import 'package:cloudinary_dart/uploader/uploader_response.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';
import 'package:cloudinary_dart_url_gen/config/api_config.dart';
import 'package:http/http.dart';


import '../src/http/session/network_delegate.dart';
import '../src/http/request/multi_part_request.dart';
import '../src/request/network_request.dart';
import '../src/request/params/upload_params.dart';
import '../src/request/payload.dart';
import '../src/request/upload_request.dart';
import '../src/response/upload_error.dart';
import '../src/response/upload_result.dart';

class Uploader {

  Cloudinary cloudinary;
  final networkDelegate = NetworkDelegate();

  Uploader(this.cloudinary);


  // Api calls
  Future<UploaderResponse<UploadResult>?> upload(dynamic file,
      {UploadParams? params, ProgressCallback? progressCallback, Map<
          String,
          String>? extraHeaders}) {
    Payload<dynamic> payload = buildPayload(file);
    UploadRequest request = UploadRequest(
        this, params ?? UploadParams(), payload,
        progressCallback: progressCallback, extraHeaders: extraHeaders);
    return request.execute();
  }

  NetworkRequest prepareNetworkRequest(String action, UploadRequest request,
      String adapter) {
    var config = cloudinary.config.cloudConfig;
    var prefix = cloudinary.config.apiConfig.uploadPrefix;
    var cloudName = cloudinary.config.cloudConfig.cloudName;
    var resourceType = defaultResourceType;

    Map<String, dynamic> paramsMap = request.buildParams();

    // if(requireSigning(action, request.params, request)) {
    //   if (config.cloudConfig.apiKey != null) {
    //
    //   } else {
    //     ArgumentError("Must supply api_secret");
    //   }
    //
    //   paramsMap['timestamp'] = DateTime.now().millisecondsSinceEpoch;
    //   paramsMap['signature'] = apiSignRequest(request.params, config.cloudConfig.apiSecret);
    //   paramsMap['apiKey'] = config.cloudConfig.apiKey;
    // }

    var url = [prefix, apiVersion, cloudName, resourceType, action]
        .noNullList()
        .join("/");

    return NetworkRequest(
        url,
        request.params.filename,
        request.extraHeaders ?? <String, String>{},
        paramsMap,
        adapter,
        request.payload,
        request.progressCallback);
  }

  Future<UploaderResponse<UploadResult>> callApi(
      AbstractUploaderRequest request, String action, String adapter) async {
    return processResponse(await networkDelegate.callApi(
        prepareNetworkRequest(action, (request as UploadRequest), adapter)));
  }

  Future<UploaderResponse<UploadResult>>? performUpload(UploadRequest request) {
    if (request.payload == null) {
      ArgumentError('An upload request must have a payload');
    }
    var value = request.payload.value;
    var payload = request.payload;
    var chunkSize = request.uploader.cloudinary.config.apiConfig.chunkSize;
    // if it's a remote url or the total size is known and smaller than chunk size we fallback to
    // a regular upload api (no need for chunks)
    if (value is String && isRemoteUrl(value) ||
        (1 > payload.length || payload.length < chunkSize!)) {
      return callApi(request, 'upload', 'UploadResult');
    }
    //Upload large
    var uniqueUploadId = createRandomUploadId(8);
    uploadLargeParts(payload, request, uniqueUploadId)!;
    return callApi(request, 'upload', 'UploadResult');
  }


  bool isRemoteUrl(String value) {
    return RegExp(
        'ftp:.*|https?:.*|s3:.*|gs:.*|data:([w-]+/[w-]+)?(;[w-]+=[w-]+)*;base64,([a-zA-Z0-9/+ =]+)')
        .hasMatch(value);
  }

  Payload buildPayload(dynamic file) {
    if (file is File) {
      return FilePayload(file);
    } else if (file is String) {
      return UrlPayload(file);
    } else if (file is Stream) {
      return StreamPayload(file);
    }
    throw ArgumentError("Current file type is not supported");
  }

  Future<UploaderResponse<UploadResult>> processResponse(
      StreamedResponse? requestResponse) {
    return getProcessedResponse(
        requestResponse!.statusCode,
        requestResponse.stream,
        requestResponse!.headers['x-cld-error']);
  }

  Future<UploaderResponse<UploadResult>> getProcessedResponse(int statusCode,
      ByteStream? stream, String? errorHeader) async {
    String body = await stream?.transform(utf8.decoder).join() ?? "";
    if (statusCode >= 200 && statusCode <= 299) {
      if (body != null) {
        var response =
        UploaderResponse<UploadResult>(statusCode, body, null, body);
        return response;
      } else {
        var responseError = UploadError("Error");
        return UploaderResponse(statusCode, null, responseError, body);
      }
    } else if (statusCode >= 400 && statusCode < 499) {
      return UploaderResponse(
          statusCode, null, UploadError(errorHeader ?? "Unknown Error"),
          body);
    } else if (statusCode >= 500 && statusCode < 500) {
      return UploaderResponse(
          statusCode, null, UploadError(
          errorHeader ?? "We had an problem, please contact support"),
          body);
    }
    return UploaderResponse(
        statusCode, null, UploadError(errorHeader ?? "Unknown Error"),
        body);
  }

  Future<UploaderResponse<UploadResult>?> uploadLargeParts(Payload payload,
      UploadRequest request, String uniqueUploadId) async {
    Future<UploaderResponse<UploadResult>> response;
    int chunkSize = cloudinary.config.apiConfig.chunkSize!;
    Map<String, String> extraHeaders = request.extraHeaders ??
        <String, String>{};

    request.extraHeaders?.addEntries({'X-Unique-Upload-Id': uniqueUploadId}.entries);
    int chunkCount = (payload.length / chunkSize).round();

    for (int index = 0; index < chunkCount; index++) {
      final startOffset = getStartOffset(index, chunkSize);
      final endOffset = getEndOffset(index, chunkSize, payload.length);
      final stream = getStream(startOffset, endOffset, payload);
      return processResponse(await networkDelegate.uploadLarge(
          stream, prepareNetworkRequest('upload', request, ''), startOffset,
          endOffset, payload.length));
    }
    return null;
  }

  int getStartOffset(int index, int chunkSize) {
    return index * chunkSize;
  }

  int getEndOffset(int index, int chunkSize, int fileSize) {
    return min((index + 1) * chunkSize, fileSize);
  }

  Stream<List<int>> getStream(int start, int end, Payload payload) {
    return (payload as FilePayload).value.openRead(start, end);
  }

  final Random _random = Random();
  String createRandomUploadId(int length) {
    StringBuffer sb = StringBuffer();
    for (var i = 0; i < length; i++) {
      sb.write(_random.nextInt(16).toRadixString(16));
    }
    return sb.toString();
  }
}