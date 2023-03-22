import 'package:cloudinary_dart_uploader/uploader/uploader_internal.dart';
import 'package:cloudinary_dart_uploader/uploader/uploader_response.dart';

import '../../uploader/abstract_uploader_request.dart';
import '../../uploader/uploader.dart';
import '../response/upload_result.dart';
import '../http/request/multi_part_request.dart';
import 'model/uploader_params.dart';
import 'payload.dart';

class UploadRequest implements AbstractUploaderRequest<UploadResult> {
  @override
  Uploader uploader;
  @override
  UploaderParams? params;
  @override
  Payload<dynamic>? payload;
  @override
  ProgressCallback? progress;
  @override
  CompletionCallback? completionCallback;

  UploadRequest(this.uploader, this.params, this.payload,
      {this.progress, this.completionCallback});

  Future<UploaderResponse<UploadResult>>? execute() {
    return uploader._performUpload(this);
  }

  @override
  Map<String, dynamic> buildParams() {
    return params?.buildParams() ?? <String, dynamic>{};
  }
}
