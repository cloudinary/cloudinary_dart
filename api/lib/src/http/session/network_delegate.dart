import 'package:cloudinary_api/uploader/utils.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import '../../request/network_request.dart';
import '../request/multi_part_request.dart';

class NetworkDelegate {
  final boundary = Utils.getRandomString(16);

  Future<http.StreamedResponse> callApi(NetworkRequest request) async {
    var multiPartRequest = _buildRequest(request);
    if (request.payload != null) {
      multiPartRequest.files.add((request.payload!.path != null)
          ? await http.MultipartFile.fromPath(
              'file', request.payload?.path ?? request.payload!.value,
              filename: request.filename)
          : http.MultipartFile.fromString('file', request.payload!.value));
    }
    return await multiPartRequest
        .send()
        .timeout(Duration(seconds: request.timeout));
  }

  Future<http.StreamedResponse> uploadLarge(
      Stream<List<int>> stream,
      NetworkRequest request,
      int startOffset,
      int endOffset,
      int totalSize) async {
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
    return await multiPartRequest
        .send()
        .timeout(Duration(seconds: request.timeout));
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
}

extension NetworkDelegateUtils on NetworkDelegate {
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
}
