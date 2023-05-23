import '../http/request/multi_part_request.dart';
import 'payload.dart';

class NetworkRequest<T> {
  String url;
  String? filename;
  Map<String, String> headers;
  Map<String, dynamic> params;
  Payload<dynamic>? payload;
  ProgressCallback? progressCallback;
  CompletionCallback? completionCallback;
  int timeout;

  NetworkRequest(
      this.url,
      this.filename,
      this.headers,
      this.params,
      this.timeout,
      this.payload,
      this.progressCallback,
      this.completionCallback);
}
