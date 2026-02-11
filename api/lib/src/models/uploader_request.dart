import 'package:cloudinary_api/src/http/request/multi_part_request.dart';
import 'package:cloudinary_api/src/models/uploader_params.dart';
import 'package:cloudinary_api/src/models/payload.dart';
import 'package:cloudinary_api/src/uploader/abstract_uploader_request.dart';
import 'upload_result.dart';

class UploaderRequest implements AbstractUploaderRequest<UploadResult> {
  @override
  CompletionCallback? completionCallback;

  @override
  UploaderParams? params;

  @override
  Payload? payload;

  @override
  ProgressCallback? progress;

  UploaderRequest(this.params);

  @override
  Map<String, dynamic> buildParams() {
    return params?.buildParams() ?? <String, dynamic>{};
  }
}
