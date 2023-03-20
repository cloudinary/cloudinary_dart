import 'package:cloudinary_dart_uploader/uploader/uploader.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';

extension CloudinaryUploader on Cloudinary {
  Uploader uploader() {
    return Uploader(this);
  }
}
