import 'dart:convert';
import 'package:cloudinary_dart/request/network_request.dart';
import 'package:cloudinary_dart/response/upload_error.dart';
import 'package:cloudinary_dart/response/upload_result.dart';
import 'package:http/http.dart';
import '../../uploader/uploader_response.dart';
import 'package:http/http.dart' as http;

class NetworkDelegate {
  NetworkDelegate();

  Future<UploaderResponse<UploadResult>> callApi(NetworkRequest request) async {
    StreamedResponse requestResponse;
      var multiPartRequest =
          http.MultipartRequest('POST', Uri.parse(request.url));

      multiPartRequest.fields.addAll(paramsToFields(request.params));
      multiPartRequest.files.add(await http.MultipartFile.fromPath(
          'file', request.payload.path));
      requestResponse = await multiPartRequest.send();
    return processResponse(requestResponse, request.adapter);
  }

  Future<UploaderResponse<UploadResult>> processResponse(
      http.StreamedResponse? requestResponse, String adapter) {
    return getProcessedResponse(
        requestResponse!.statusCode,
        requestResponse!.stream,
        requestResponse!.headers['x-cld-error'],
        adapter);
  }

  Future<UploaderResponse<UploadResult>> getProcessedResponse(int statusCode,
      ByteStream stream, String? errorHeader, String adapter) async {
    String body = await stream.transform(utf8.decoder).join();
    if (statusCode >= 200 && statusCode <= 299) {
      if (body != null) {
        var response =
            UploaderResponse<UploadResult>(statusCode, body, null, body);
        return response;
      } else {
        var responseError = UploadError("Error");
        return UploaderResponse(statusCode, null, responseError, body);
      }
    } else {
      return UploaderResponse(
          statusCode, null, UploadError(errorHeader ?? "Unknown Error"), body);
    }
  }

  Map<String, String> paramsToFields(Map<String, dynamic> params) {
    Map<String, String> stringQueryParameters =
        params.map((key, value) => MapEntry(key, value.toString()));
    return stringQueryParameters;
  }
}
