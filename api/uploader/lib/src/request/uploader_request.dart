import 'package:cloudinary_dart_uploader/src/http/request/multi_part_request.dart';
import 'package:cloudinary_dart_uploader/src/request/model/uploader_params.dart';
import 'package:cloudinary_dart_uploader/src/request/payload.dart';
import 'package:cloudinary_dart_uploader/uploader/abstract_uploader_request.dart';
import 'package:cloudinary_dart_uploader/uploader/uploader.dart';
import 'package:cloudinary_dart_uploader/uploader/uploader_internal.dart';

import '../../uploader/uploader_response.dart';
import '../response/upload_result.dart';
import 'model/shared_params.dart';

class UploaderRequest implements AbstractUploaderRequest<UploadResult> {
  String action;

  @override
  CompletionCallback? completionCallback;

  @override
  UploaderParams? params;

  @override
  Payload? payload;

  @override
  ProgressCallback? progress;

  @override
  Uploader uploader;

  UploaderRequest(this.action, this.uploader, this.params);

  @override
  Map<String, dynamic> buildParams() {
    return params?.buildParams() ?? <String, dynamic>{};
  }

  @override
  Future<UploaderResponse<UploadResult>> execute() {
    return uploader.callApi(this, action, options: SharedParams());
  }
}
