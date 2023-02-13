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
  Future<UploaderResponse<UploadResult>?> upload(File file, {UploadParams? params, UploaderOptions? options, CloudinaryConfig? cloudinaryConfig}) {
    FilePayload payload = FilePayload(file);
    UploadRequest request = UploadRequest(this, params ?? UploadParams(), options ?? UploaderOptions(), cloudinaryConfig ?? cloudinary.config, payload);
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
}