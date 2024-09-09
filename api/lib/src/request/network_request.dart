import '../http/request/multi_part_request.dart';
import 'payload.dart';

class NetworkRequest<T> {
  String url;
  Map<String, String> headers;
  Map<String, dynamic> params;
  Payload<dynamic>? payload;
  ProgressCallback? progressCallback;
  CompletionCallback? completionCallback;
  int timeout;
  String? filename;

  NetworkRequest(
      this.url,
      this.headers,
      this.params,
      this.timeout,
      this.filename,
      this.payload,
      this.progressCallback,
      this.completionCallback);
}
