import 'package:cloudinary_api/uploader/uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';

extension CloudinaryUploader on Cloudinary {
  Uploader uploader() {
    return Uploader(this);
  }
}
