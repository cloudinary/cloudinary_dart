import 'package:cloudinary_api_dart/uploader/uploader.dart';
import 'package:cloudinary_url_gen_dart/cloudinary.dart';

extension CloudinaryUploader on Cloudinary {
  Uploader uploader() {
    return Uploader(this);
  }
}
