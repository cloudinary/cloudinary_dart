
import 'package:cloudinary_dart/src/request/params/upload_options.dart';
import 'package:cloudinary_dart/uploader/uploader.dart';
import 'package:cloudinary_dart/uploader/uploader_response.dart';

import '../src/http/request/multi_part_request.dart';
import '../src/request/payload.dart';


abstract class AbstractUploaderRequest<T> {
  late Uploader uploader;
  late Payload<dynamic> payload;
  late ProgressCallback? progressCallback;
  late UploadOptions? options;

  Map<String, dynamic> buildParams();

  CldMultipartRequest execute()  {
    // TODO: implement execute
    throw UnimplementedError();
  }
}