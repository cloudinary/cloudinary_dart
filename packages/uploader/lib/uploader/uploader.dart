import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_dart/src/http/extensions/list_extension.dart';
import 'package:cloudinary_dart/src/request/model/upload_options.dart';
import 'package:cloudinary_dart/uploader/abstract_uploader_request.dart';
import 'package:cloudinary_dart/uploader/uploader_response.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';
import 'package:cloudinary_dart_url_gen/config/api_config.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';


import '../src/http/session/network_delegate.dart';
import '../src/http/request/multi_part_request.dart';
import '../src/request/network_request.dart';
import '../src/request/model/upload_params.dart';
import '../src/request/payload.dart';
import '../src/request/upload_request.dart';
import '../src/response/upload_result.dart';

class Uploader {

  Cloudinary cloudinary;
  final networkDelegate = NetworkDelegate();

  Uploader(this.cloudinary);


  // Api calls
  CldMultipartRequest upload(dynamic file,
      {UploadParams? params, UploadOptions? options, ProgressCallback? progressCallback,
        Map<String, String>? extraHeaders, CompletionCallback? completion }) {
    Payload<dynamic> payload = buildPayload(file);
    UploadRequest request = UploadRequest(
        this, params ?? UploadParams(), payload,
        progressCallback: progressCallback, options: options, completionCallback: completion);
    return request.execute();
  }

  NetworkRequest prepareNetworkRequest(String action, UploadRequest request,
      String adapter) {
    var config = cloudinary.config.cloudConfig;
    var prefix = cloudinary.config.apiConfig.uploadPrefix;
    var cloudName = cloudinary.config.cloudConfig.cloudName;
    var resourceType = request.options?.resourceType ?? defaultResourceType;

    Map<String, dynamic> paramsMap = request.buildParams();

    if(requireSigning(action, request.params, request)) {
      if (config.apiKey == null) {
        ArgumentError("Must supply api_secret");
      }
      if(request.params.signature != null) {
        paramsMap['signature'] = request.params.signature!;
      } else {
      paramsMap['timestamp'] = (DateTime.now().millisecondsSinceEpoch / 1000).toString();
      paramsMap['signature'] = apiSignRequest(paramsMap, config.apiSecret!);
      paramsMap['api_key'] = config.apiKey;
      }
    }

    var url = [prefix, apiVersion, cloudName, resourceType, action]
        .noNullList()
        .join("/");

    return NetworkRequest(
        url,
        request.options?.filename,
        request.options?.extraHeaders ?? <String, String>{},
        paramsMap,
        adapter,
        request.payload,
        request.progressCallback,
        request.completionCallback);
  }

  CldMultipartRequest callApi(
      AbstractUploaderRequest request, String action, String adapter) {
    return networkDelegate.callApi(
        prepareNetworkRequest(action, (request as UploadRequest), adapter));
    // return processResponse( );
  }

  CldMultipartRequest performUpload(UploadRequest request) {
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
    return uploadLargeParts(payload, request, uniqueUploadId)!;
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

  CldMultipartRequest uploadLargeParts(Payload payload,
      UploadRequest request, String uniqueUploadId) {
    late CldMultipartRequest multiRequest;
    Future<UploaderResponse<UploadResult>> response;
    int chunkSize = cloudinary.config.apiConfig.chunkSize!;
    Map<String, String> extraHeaders = request.options?.extraHeaders ??
        <String, String>{};

    request.options?.extraHeaders?.addEntries({'X-Unique-Upload-Id': uniqueUploadId}.entries);
    int chunkCount = (payload.length / chunkSize).round();

    for (int index = 0; index < chunkCount; index++) {
      final startOffset = getStartOffset(index, chunkSize);
      final endOffset = getEndOffset(index, chunkSize, payload.length);
      final stream = getStream(startOffset, endOffset, payload);
      multiRequest = networkDelegate.uploadLarge(stream, prepareNetworkRequest('upload', request, ''), startOffset, endOffset, payload.length);
    }
    return multiRequest;
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

  bool requireSigning(String action, UploadParams params, UploadRequest request) {
    var missingSignature = (params.signature != null) ? false : true;
    var signedRequest = ((request.params.unsigned != null) ? !request.params.unsigned! : false);
    var actionRequiresSigning = action != 'delete_by_token';
    return missingSignature && signedRequest && actionRequiresSigning;
  }

  String apiSignRequest(Map<String, dynamic> paramsMap, String apiSecret) {
    List<String> paramsArr = <String>[];
    var sortedParams = paramsMap.keys.toList()..sort();
    for(var key in sortedParams) {
       var value = paramsMap[key];
       String? paramValue;
       if(value is List<String>) {
         if(value.isNotEmpty) {
            paramValue = value.join(',');
         } else {
           continue;
         }
       } else {
         if(value != null) {
           paramValue = value.toString();
         }
       }
       if(paramValue != null) {
         paramsArr.add('$key=$paramValue');
       }
    }
    var toSign = '${paramsArr.join('&')}$apiSecret';
    return hex.encode(sha1.convert(utf8.encode(toSign)).bytes);
  }

}