import '../src/response/upload_error.dart';

class UploaderResponse<T> {
  int responseCode;
  T? data;
  UploadError? error;
  String? rawResponse;

  UploaderResponse(this.responseCode, this.data, this.error, this.rawResponse);
}
