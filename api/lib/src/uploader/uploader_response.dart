import '../models/upload_error.dart';

class UploaderResponse<T> {
  int responseCode;
  T? data;
  UploadError? error;
  String? rawResponse; //FIXME: Set variable to Map<String, dynamic>

  UploaderResponse(this.responseCode, this.data, this.error, this.rawResponse);
}
