import 'dart:io';
import 'dart:math';

import 'package:cloudinary_dart_uploader/src/http/extensions/list_extension.dart';
import 'package:cloudinary_dart_uploader/uploader/uploader.dart';
import 'package:cloudinary_dart_uploader/uploader/uploader_response.dart';
import 'package:cloudinary_dart_uploader/uploader/utils.dart';
import 'package:cloudinary_dart_url_gen/config/api_config.dart';

import '../src/http/request/multi_part_request.dart';
import '../src/request/model/shared_params.dart';
import '../src/request/network_request.dart';
import '../src/request/payload.dart';
import '../src/request/upload_request.dart';
import '../src/response/upload_result.dart';
import 'abstract_uploader_request.dart';

extension InternalUploader on Uploader {
  NetworkRequest prepareNetworkRequest(
      String action, AbstractUploaderRequest request, SharedParams? options) {
    var config = cloudinary.config.cloudConfig;
    var prefix = cloudinary.config.apiConfig.uploadPrefix;
    var cloudName = cloudinary.config.cloudConfig.cloudName;
    var resourceType = options?.resourceType ?? defaultResourceType;

    Map<String, dynamic> paramsMap = request.buildParams();

    if (requireSigning(action, options, paramsMap['signature'])) {
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
        request.payload,
        request.progressCallback,
        request.completionCallback);
  }

  CldMultipartRequest callApi(AbstractUploaderRequest request, String action,
      {SharedParams? options}) {
    return networkDelegate.callApi(
        prepareNetworkRequest(action, (request as UploadRequest), options));
  }

  Future<UploaderResponse<UploadResult>> callApiSync(
      AbstractUploaderRequest request, String action,
      {SharedParams? options}) {
    return networkDelegate
        .callApiSync(prepareNetworkRequest(action, request, options));
  }

  Future<UploaderResponse<UploadResult>> performUploadSync(
      UploadRequest request) {
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
        extraHeaders: request.params?.extraHeaders);
    if (value is String && Utils.isRemoteUrl(value) ||
        (1 > payload.length || payload.length < chunkSize!)) {
      // need to make sure if we have length or not.
      return callApiSync(request, 'upload', options: options);
    }
    throw ArgumentError('File is too large for synchronize upload');
  }

  CldMultipartRequest? performUpload(UploadRequest request) {
    if (request.payload == null) {
      ArgumentError('An upload request must have a payload');
    }
    var payload = request.payload!;
    var value = payload.value;
    var chunkSize = request.uploader.cloudinary.config.apiConfig.chunkSize;
    // if it's a remote url or the total size is known and smaller than chunk size we fallback to
    // a regular upload api (no need for chunks)
    SharedParams options = SharedParams(
        resourceType: request.params?.resourceType,
        unsigned: request.params?.unsigned,
        filename: request.params?.filename,
        extraHeaders: request.params?.extraHeaders);
    if (value is String && Utils.isRemoteUrl(value) ||
        (1 > payload.length || payload.length < chunkSize!)) {
      // need to make sure if we have length or not.
      return callApi(request, 'upload', options: options);
    }
    //Upload large
    var uniqueUploadId = Utils.createRandomUploadId(8);
    uploadLargeParts(payload, request, uniqueUploadId);
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

  void uploadLargeParts(
      Payload payload, UploadRequest request, String uniqueUploadId) async {
    late UploaderResponse<UploadResult> response;
    int chunkSize = cloudinary.config.apiConfig.chunkSize!;
    request.params?.extraHeaders = <String, String>{};
    request.params?.extraHeaders
        ?.addEntries({'X-Unique-Upload-Id': uniqueUploadId}.entries);
    int chunkCount = (payload.length / chunkSize).ceil();

    int index = 0;
    for (int index = 0; index < chunkCount; index++) {
      await buildStreamRequest(index, chunkSize, payload, request);
    }
  }

  Future<CldMultipartRequest> buildStreamRequest(
      int index, int chunkSize, Payload payload, UploadRequest request) async {
    final startOffset = getStartOffset(index, chunkSize);
    final endOffset = getEndOffset(index, chunkSize, payload.length);
    final stream = getStream(startOffset, endOffset, payload);
    SharedParams options = SharedParams(
        resourceType: request.params?.resourceType,
        unsigned: request.params?.unsigned,
        filename: request.params?.filename ?? payload.name,
        extraHeaders: request.params?.extraHeaders);
    return await networkDelegate.uploadLarge(
        stream,
        prepareNetworkRequest('upload', request, options),
        startOffset,
        endOffset,
        payload.length);
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

  bool requireSigning(String action, SharedParams? options, String? signature) {
    var missingSignature = (signature != null) ? false : true;
    var signedRequest =
        ((options?.unsigned != null) ? !options!.unsigned! : false);
    var actionRequiresSigning = action != 'delete_by_token';
    return missingSignature && signedRequest && actionRequiresSigning;
  }
}
