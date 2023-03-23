import 'package:cloudinary_dart_uploader/src/http/request/multi_part_request.dart';
import 'package:cloudinary_dart_uploader/src/request/model/uploader_params.dart';
import 'package:cloudinary_dart_uploader/src/request/payload.dart';
import 'package:cloudinary_dart_uploader/uploader/abstract_uploader_request.dart';
import '../response/upload_result.dart';

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
