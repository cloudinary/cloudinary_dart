import '../http/request/multi_part_request.dart';
import 'payload.dart';

class NetworkRequest<T> {
  String url;
  String? filename;
  Map<String, String> headers;
  Map<String, dynamic> params;
  String adapter;
  Payload<dynamic> payload;
  ProgressCallback? progressCallback;
  CompletionCallback? completionCallback;

  NetworkRequest(
      this.url,
      this.filename,
      this.headers,
      this.params,
      this.adapter,
      this.payload,
      this.progressCallback,
      this.completionCallback);
}
