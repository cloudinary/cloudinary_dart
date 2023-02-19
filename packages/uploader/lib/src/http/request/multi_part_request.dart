import 'dart:async';

import 'package:http/http.dart' as http;

typedef ProgressCallback = void Function(int bytesUploaded, int totalBytes);

class CldMultipartRequest extends http.MultipartRequest {
  final ProgressCallback? onProgress;

  Map<String, String> headers;

  /// Creates a new [CldMultipartRequest].
  CldMultipartRequest(String method, Uri url, this.headers, {this.onProgress})
      : super(method, url);

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        if (onProgress != null) {
          onProgress!(bytes, total);
        }
        if (total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }

  @override
  Future<http.StreamedResponse> send() async {
    var client = http.Client();

    try {
      var response = await client.send(this);
      var stream = onDone(response.stream, client.close);
      return http.StreamedResponse(http.ByteStream(stream), response.statusCode,
          contentLength: response.contentLength,
          request: response.request,
          headers: response.headers,
          isRedirect: response.isRedirect,
          persistentConnection: response.persistentConnection,
          reasonPhrase: response.reasonPhrase);
    } catch (_) {
      client.close();
      rethrow;
    }
  }

  Stream<T> onDone<T>(Stream<T> stream, void Function() onDone) =>
      stream.transform(StreamTransformer.fromHandlers(handleDone: (sink) {
        sink.close();
        onDone();
      }));
}

