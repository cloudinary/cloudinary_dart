import 'dart:async';

import 'package:http/http.dart' as http;

typedef ProgressCallback = void Function(int bytesUploaded, int totalBytes);

class CldMultipartRequest extends http.MultipartRequest {

  final ProgressCallback? onProgress;

  /// Creates a new [MultipartRequest].
  CldMultipartRequest(
      String method,
      Uri url, {
        this.onProgress,
      }) : super(method, url);

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
        if(onProgress != null) {
          onProgress!(bytes, total);
        }
        if(total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
