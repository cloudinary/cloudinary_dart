import 'dart:io';

import 'package:cloudinary_dart/http/extensions/list_extension.dart';
import 'package:cloudinary_dart/request/params/upload_params.dart';
import 'package:cloudinary_dart/request/payload.dart';
import 'package:cloudinary_dart/request/uploader_options.dart';
import 'package:cloudinary_dart/response/upload_result.dart';
import 'package:cloudinary_dart/uploader/abstract_uploader_request.dart';
import 'package:cloudinary_dart/uploader/uploader_response.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';
import 'package:cloudinary_dart_url_gen/config/api_config.dart';
import 'package:cloudinary_dart_url_gen/config/cloudinary_config.dart';

import '../http/session/network_delegate.dart';
import '../request/network_request.dart';
import '../request/upload_request.dart';

class Uploader {

  Cloudinary cloudinary;
  final networkDelegate = NetworkDelegate();

  Uploader(this.cloudinary);


  // Api calls
  Future<UploaderResponse<UploadResult>?> upload(File file, {UploadParams? params, UploaderOptions? options, CloudinaryConfig? cloudinaryConfig, ProgressCallback? progressCallback}) {
    FilePayload payload = FilePayload(file);
    UploadRequest request = UploadRequest(this, params ?? UploadParams(), options ?? UploaderOptions(), cloudinaryConfig ?? cloudinary.config, payload, progressCallback: progressCallback);
    return request.execute();
  }

  NetworkRequest prepareNetworkRequest(String action, UploadRequest request, String adapter) {
    var config = request.cloudinaryConfig;
    var prefix = config.apiConfig.uploadPrefix;
    var cloudName = config.cloudConfig.cloudName;
    var resourceType = (action != 'delete_by_token') ? request.options.resourceType ?? defaultResourceType : defaultResourceType;

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

    return NetworkRequest(url, request.options.filename, request.options.headers ?? <String, String>{}, paramsMap, adapter, request.payload);//, request.progressCallback);
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
    var chunkSize = request.options.chunkSize ?? request.cloudinaryConfig.apiConfig.chunkSize;
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