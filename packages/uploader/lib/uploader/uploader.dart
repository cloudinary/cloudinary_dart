import 'dart:io';
import 'package:cloudinary_dart/src/http/extensions/list_extension.dart';
import 'package:cloudinary_dart/uploader/abstract_uploader_request.dart';
import 'package:cloudinary_dart/uploader/uploader_response.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';
import 'package:cloudinary_dart_url_gen/config/api_config.dart';

import '../src/http/session/network_delegate.dart';
import '../src/http/request/multi_part_request.dart';
import '../src/request/network_request.dart';
import '../src/request/params/upload_params.dart';
import '../src/request/payload.dart';
import '../src/request/upload_request.dart';
import '../src/response/upload_result.dart';

class Uploader {

  Cloudinary cloudinary;
  final networkDelegate = NetworkDelegate();

  Uploader(this.cloudinary);


  // Api calls
  Future<UploaderResponse<UploadResult>?> upload(File file, {UploadParams? params, ProgressCallback? progressCallback, Map<String, String>? extraHeaders}) {
    FilePayload payload = FilePayload(file);
    UploadRequest request = UploadRequest(this, params ?? UploadParams(), payload, progressCallback: progressCallback, extraHeaders: extraHeaders);
    return request.execute();
  }

  NetworkRequest prepareNetworkRequest(String action, UploadRequest request, String adapter) {
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

    var url = [prefix, apiVersion, cloudName, resourceType, action].noNullList().join("/");

    return NetworkRequest(url, request.params.filename, request.extraHeaders ?? <String, String>{}, paramsMap, adapter, request.payload, request.progressCallback);
  }

  Future<UploaderResponse<UploadResult>> callApi(AbstractUploaderRequest request, String action, String adapter) async {
    return await networkDelegate.callApi(prepareNetworkRequest(action, (request as UploadRequest), adapter));
  }

  Future<UploaderResponse<UploadResult>> performUpload(UploadRequest request) {
    if(request.payload == null) {
      ArgumentError('An upload request must have a payload');
    }
    var value = request.payload.value;
    var payload = request.payload;
    var chunkSize = request.uploader.cloudinary.config.apiConfig.chunkSize;
    // if it's a remote url or the total size is known and smaller than chunk size we fallback to
    // a regular upload api (no need for chunks)
    if(value is String && isRemoteUrl(value) || (1 > payload.length || payload.length < chunkSize!)) {
      return callApi(request, 'upload', 'UploadResult');
    }
    //Upload large
    return callApi(request, 'upload', 'UploadResult');
  }

  bool isRemoteUrl(String value) {
    return RegExp('ftp:.*|https?:.*|s3:.*|gs:.*|data:([w-]+/[w-]+)?(;[w-]+=[w-]+)*;base64,([a-zA-Z0-9/+ =]+)').hasMatch(value);
  }
}