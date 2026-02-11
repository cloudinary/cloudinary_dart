import '../uploader/abstract_uploader_request.dart';
import 'upload_result.dart';
import '../http/request/multi_part_request.dart';
import 'uploader_params.dart';
import 'payload.dart';

class UploadRequest implements AbstractUploaderRequest<UploadResult> {
  @override
  UploaderParams? params;
  @override
  Payload<dynamic>? payload;
  @override
  ProgressCallback? progress;
  @override
  CompletionCallback? completionCallback;

  UploadRequest(this.params, this.payload,
      {this.progress, this.completionCallback});

  @override
  Map<String, dynamic> buildParams() {
    var options = params?.buildParams() ?? <String, dynamic>{};
    options.removeWhere((key, value) => value == null);
    return options;
  }
}
