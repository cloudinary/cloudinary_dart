
import 'package:cloudinary_dart/uploader/uploader.dart';
import 'package:cloudinary_dart/uploader/uploader_response.dart';

import '../src/http/request/multi_part_request.dart';
import '../src/request/payload.dart';


abstract class AbstractUploaderRequest<T> {
  late Uploader uploader;
  late Payload<dynamic> payload;
  late ProgressCallback? progressCallback;
  Map<String, String>? extraHeaders = {};

  Map<String, dynamic> buildParams();

  Future<UploaderResponse<T>?> execute()  {
    // TODO: implement execute
    throw UnimplementedError();
  }
}