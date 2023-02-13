import 'package:cloudinary_dart/request/payload.dart';
import 'package:cloudinary_dart/request/uploader_options.dart';
import 'package:cloudinary_dart/uploader/uploader.dart';
import 'package:cloudinary_dart/uploader/uploader_response.dart';
import 'package:cloudinary_dart_url_gen/config/cloudinary_config.dart';

abstract class AbstractUploaderRequest<T> {
  late Uploader uploader;
  late UploaderOptions options;
  late CloudinaryConfig cloudinaryConfig;
  late Payload<dynamic> payload;
  // ProgressCallback progressCallback;

  Map<String, dynamic> buildParams();

  Future<UploaderResponse<T>?> execute()  {
    // TODO: implement execute
    throw UnimplementedError();
  }
}