import 'dart:convert';

import 'package:cloudinary_dart/src/http/request/multi_part_request.dart';
import 'package:cloudinary_dart/src/request/upload_request.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../uploader/uploader_response.dart';
import '../../request/network_request.dart';
import '../../response/upload_error.dart';
import '../../response/upload_result.dart';

class NetworkDelegate {
  NetworkDelegate();

  CldMultipartRequest callApi(NetworkRequest request) {
    Future<StreamedResponse> requestResponse;
    request.headers.addEntries(addUserAgent());
    var multiPartRequest = CldMultipartRequest(
        'POST', Uri.parse(request.url), request.headers,
        onProgress: request.progressCallback);
    http.MultipartFile.fromPath('file', request.payload.path).then((file) {
      multiPartRequest.fields.addAll(paramsToFields(request.params));
      multiPartRequest.files.add(file);
      requestResponse = multiPartRequest.send();
      if (request.completionCallback != null) {
        requestResponse.then(
            (requestResponse) {
              processResponse(requestResponse, (response) {
                request.completionCallback!(response);
              });
            });
      }
    });
    return multiPartRequest;
  }

  Future<StreamedResponse> uploadLarge(
      Stream<List<int>> stream,
      NetworkRequest request,
      int startOffset,
      int endOffset,
      int totalSize) async {
    StreamedResponse requestResponse;
    request.headers.addEntries(addUserAgent());
    request.headers
        .addEntries(addContentRange(startOffset, endOffset, totalSize));
    var multiPartRequest = CldMultipartRequest(
        'POST', Uri.parse(request.url), request.headers,
        onProgress: request.progressCallback);
    multiPartRequest.fields.addAll(paramsToFields(request.params));
    multiPartRequest.files
        .add(MultipartFile("file", stream, endOffset - startOffset));
    requestResponse = await multiPartRequest.send();
    return requestResponse;
  }

  void processResponse(StreamedResponse? requestResponse,
      void Function(UploaderResponse<UploadResult> response) completion) {
    getProcessedResponse(requestResponse!.statusCode, requestResponse.stream,
        requestResponse!.headers['x-cld-error'], (response) {
      completion(response);
    });
  }

  void getProcessedResponse(
      int statusCode,
      ByteStream? stream,
      String? errorHeader,
      void Function(UploaderResponse<UploadResult> response) completion) {
    parseResponse(stream, (body) {
      if (statusCode >= 200 && statusCode <= 299) {
        if (body != null) {
          completion(
              UploaderResponse<UploadResult>(statusCode, body, null, body));
          return;
        } else {
          var responseError = UploadError("Error");
          completion(UploaderResponse(statusCode, null, responseError, body));
          return;
        }
      } else if (statusCode >= 400 && statusCode < 499) {
        completion(UploaderResponse(statusCode, null,
            UploadError(errorHeader ?? "Unknown Error"), body));
        return;
      } else if (statusCode >= 500 && statusCode < 500) {
        completion(UploaderResponse(
            statusCode,
            null,
            UploadError(
                errorHeader ?? "We had an problem, please contact support"),
            body));
        return;
      }
      completion(UploaderResponse(
          statusCode, null, UploadError(errorHeader ?? "Unknown Error"), body));
      return;
    });
  }

  Map<String, String> paramsToFields(Map<String, dynamic> params) {
    Map<String, String> stringQueryParameters =
        params.map((key, value) => MapEntry(key, value.toString()));
    return stringQueryParameters;
  }

  Iterable<MapEntry<String, String>> addUserAgent() {
    return {'User-Agent': Cloudinary.userAgent}.entries;
  }

  Iterable<MapEntry<String, String>> addContentRange(
      int startOffset, int endOffset, int totalSize) {
    return {
      'Content-Range':
          'bytes $startOffset-${endOffset - startOffset}/$totalSize'
    }.entries;
  }

  void parseResponse(
      http.ByteStream? stream, void Function(String result) completion) {
    stream?.transform(utf8.decoder).join().then((value) => completion(value));
  }
}
