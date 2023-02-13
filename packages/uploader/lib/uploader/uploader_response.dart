import '../response/upload_error.dart';

class UploaderResponse<T> {
  int responseCode;
  String? data;
  UploadError? error;
  String? rawResponse;

  UploaderResponse(this.responseCode, this.data, this.error, this.rawResponse);
}