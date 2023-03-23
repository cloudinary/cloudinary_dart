import 'package:cloudinary_dart_uploader/uploader/uploader.dart';
import 'package:cloudinary_dart_uploader/uploader/uploader_response.dart';

import '../src/http/request/multi_part_request.dart';
import '../src/request/model/uploader_params.dart';
import '../src/request/payload.dart';
import '../src/response/upload_result.dart';

abstract class AbstractUploaderRequest<T> {
  late Payload<dynamic>? payload;
  late ProgressCallback? progress;
  late CompletionCallback? completionCallback;
  late UploaderParams? params;

  Map<String, dynamic> buildParams() {
    return params?.buildParams() ?? <String, dynamic>{};
  }
}
