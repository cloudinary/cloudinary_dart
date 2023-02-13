import 'package:cloudinary_dart/request/payload.dart';

class NetworkRequest<T> {
  String url;
  String? filename;
  Map<String, String> headers;
  Map<String, dynamic> params;
  String adapter;
  Payload<dynamic> payload;
  // ProgressCallback progressCallback;

  NetworkRequest(this.url, this.filename, this.headers, this.params, this.adapter, this.payload);//, this.progressCallback);
}