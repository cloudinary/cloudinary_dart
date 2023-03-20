import 'dart:convert';

import 'package:cloudinary_dart_uploader/uploader/utils.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import '../../../uploader/uploader_response.dart';
import '../../request/network_request.dart';
import '../../response/upload_error.dart';
import '../../response/upload_result.dart';
import '../request/multi_part_request.dart';

class NetworkDelegate {
  final boundary = Utils.getRandomString(16);
  final lineFeed = '\r\n';

  NetworkDelegate();

  CldMultipartRequest callApi(NetworkRequest request) {
    Future<StreamedResponse> requestResponse;
    var multiPartRequest = _buildRequest(request);
    if (request.payload != null && request.payload!.path != null) {
      http.MultipartFile.fromPath(
              'file', request.payload!.path ?? request.payload!.value,
              filename: request.filename)
          .then((file) {
        multiPartRequest.files.add(file);
        requestResponse = multiPartRequest.send();
        _handleResponse(request, requestResponse);
      });
    } else {
      if (request.payload != null) {
        multiPartRequest.files
            .add(http.MultipartFile.fromString('file', request.payload!.value));
      }
      requestResponse = multiPartRequest.send();
      _handleResponse(request, requestResponse);
    }
    return multiPartRequest;
  }

  Future<UploaderResponse<UploadResult>> callApiSync(
      NetworkRequest request) async {
    StreamedResponse requestResponse;
    var multiPartRequest = _buildRequest(request);
    if (request.payload != null) {
      multiPartRequest.files.add((request.payload!.path != null)
          ? await http.MultipartFile.fromPath(
              'file', request.payload?.path ?? request.payload!.value,
              filename: request.filename)
          : http.MultipartFile.fromString('file', request.payload!.value));
    }
    requestResponse = await multiPartRequest.send();
    return await _processResponseSync(requestResponse);
  }

  Future<CldMultipartRequest> uploadLarge(
      Stream<List<int>> stream,
      NetworkRequest request,
      int startOffset,
      int endOffset,
      int totalSize) async {
    StreamedResponse requestResponse;
    request.headers.addEntries(_addUserAgent());
    request.headers
        .addEntries(_addContentRange(startOffset, endOffset, totalSize));
    var multiPartRequest = CldMultipartRequest(
        'POST', Uri.parse(request.url), request.headers,
        onProgress: request.progressCallback);
    multiPartRequest.fields.addAll(_paramsToFields(request.params));
    multiPartRequest.files.add(MultipartFile(
        "file", stream, endOffset - startOffset,
        filename: request.filename ?? 'file',
        contentType: MediaType.parse('text/plain; charset=UTF-8')));
    multiPartRequest.headers.addEntries(
        {'Content-Type': 'multipart/form-data; Stri=$boundary'}.entries);
    requestResponse = await multiPartRequest.send();
    if (request.completionCallback != null) {
      _processResponse(requestResponse, (response) {
        if (response.data?.done == true || response.error != null) {
          request.completionCallback!(response);
        }
      });
    }
    return multiPartRequest;
  }

  CldMultipartRequest _buildRequest(NetworkRequest request) {
    request.headers.addEntries(_addUserAgent());
    var multiPartRequest = CldMultipartRequest(
        'POST', Uri.parse(request.url), request.headers,
        onProgress: request.progressCallback);
    multiPartRequest.fields.addAll(_paramsToFields(request.params));
    if (request.filename != null) {
      if (request.payload != null) {
        multiPartRequest.fields.addEntries({
          request.filename!: request.payload!.path ?? request.payload!.name
        }.entries);
      }
    }
    return multiPartRequest;
  }

  Future<UploaderResponse<UploadResult>> _processResponseSync(
      StreamedResponse? requestResponse) {
    return _getProcessedResponseSync(requestResponse!.statusCode,
        requestResponse.stream, requestResponse.headers['x-cld-error']);
  }

  void _processResponse(StreamedResponse? requestResponse,
      void Function(UploaderResponse<UploadResult> response) completion) {
    _getProcessedResponse(requestResponse!.statusCode, requestResponse.stream,
        requestResponse.headers['x-cld-error'], (response) {
      completion(response);
    });
  }

  Future<UploaderResponse<UploadResult>> _getProcessedResponseSync(
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

  void _getProcessedResponse(
      int statusCode,
      ByteStream? stream,
      String? errorHeader,
      void Function(UploaderResponse<UploadResult> response) completion) {
    _parseResponse(stream, (body) {
      if (statusCode >= 200 && statusCode <= 299) {
        final parsedJson = jsonDecode(body);
        final uploadResult = UploadResult.fromJson(parsedJson);
        completion(UploaderResponse<UploadResult>(
            statusCode, uploadResult, null, body));
        return;
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

  Map<String, String> _paramsToFields(Map<String, dynamic> params) {
    Map<String, String> stringQueryParameters =
        params.map((key, value) => MapEntry(key, value.toString()));
    return stringQueryParameters;
  }

  Iterable<MapEntry<String, String>> _addUserAgent() {
    return {'User-Agent': Cloudinary.userAgent}.entries;
  }

  Iterable<MapEntry<String, String>> _addContentRange(
      int startOffset, int endOffset, int totalSize) {
    if (startOffset + endOffset >= totalSize) {
      return {'Content-Range': 'bytes $startOffset-${totalSize - 1}/$totalSize'}
          .entries;
    }
    return {
      'Content-Range':
          'bytes $startOffset-${endOffset - startOffset - 1}/$totalSize'
    }.entries;
  }

  void _parseResponse(
      http.ByteStream? stream, void Function(String result) completion) {
    stream?.transform(utf8.decoder).join().then((value) => completion(value));
  }

  void _handleResponse(
      NetworkRequest request, Future<http.StreamedResponse> requestResponse) {
    if (request.completionCallback != null) {
      requestResponse.then((requestResponse) {
        _processResponse(requestResponse, (response) {
          request.completionCallback!(response);
        });
      });
    }
  }
}
