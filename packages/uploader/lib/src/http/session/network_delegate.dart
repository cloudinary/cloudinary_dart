import 'package:cloudinary_dart/src/http/request/multi_part_request.dart';
import 'package:cloudinary_dart/src/request/upload_request.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../request/network_request.dart';

class NetworkDelegate {

  NetworkDelegate();

  Future<StreamedResponse> callApi(NetworkRequest request) async {
    StreamedResponse requestResponse;
    request.headers.addEntries(addUserAgent());
    var multiPartRequest =
        CldMultipartRequest('POST', Uri.parse(request.url), request.headers , onProgress: request.progressCallback);
    multiPartRequest.fields.addAll(paramsToFields(request.params));
    multiPartRequest.files
        .add(await http.MultipartFile.fromPath('file', request.payload.path));
    requestResponse = await multiPartRequest.send();
    return requestResponse;
  }

  Future<StreamedResponse> uploadLarge(Stream<List<int>> stream, NetworkRequest request, int startOffset, int endOffset, int totalSize) async {
    StreamedResponse requestResponse;
    request.headers.addEntries(addUserAgent());
    request.headers.addEntries(addContentRange(startOffset, endOffset, totalSize));
    var multiPartRequest =
    CldMultipartRequest('POST', Uri.parse(request.url), request.headers , onProgress: request.progressCallback);
    multiPartRequest.fields.addAll(paramsToFields(request.params));
    multiPartRequest.files
        .add(MultipartFile("file", stream, endOffset - startOffset));
    requestResponse = await multiPartRequest.send();
    return requestResponse;
  }
  //X-Unique-Upload-Id -> d6e77f3c09bbe72b
  //Content-Range -> bytes 0-5242999/5880138

  Map<String, String> paramsToFields(Map<String, dynamic> params) {
    Map<String, String> stringQueryParameters =
        params.map((key, value) => MapEntry('$key[]', value.toString()));
    return stringQueryParameters;
  }

  Iterable<MapEntry<String, String>> addUserAgent() {
    return {'User-Agent': Cloudinary.userAgent}.entries;
  }

  Iterable<MapEntry<String, String>> addContentRange(int startOffset, int endOffset, int totalSize) {
    return {'Content-Range': 'bytes $startOffset-${endOffset - startOffset}/$totalSize'}.entries;
  }
}
