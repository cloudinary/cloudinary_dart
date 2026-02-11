import '../http/request/multi_part_request.dart';
import '../models/uploader_params.dart';
import '../models/payload.dart';

abstract class AbstractUploaderRequest<T> {
  late Payload<dynamic>? payload;
  late ProgressCallback? progress;
  late CompletionCallback? completionCallback;
  late UploaderParams? params;

  Map<String, dynamic> buildParams() {
    return params?.buildParams() ?? <String, dynamic>{};
  }
}
