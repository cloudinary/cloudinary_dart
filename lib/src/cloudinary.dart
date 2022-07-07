import 'util/environment.dart';
class Cloudinary {

  String? cloudinaryUrl;

    Cloudinary.withStringUrl(this.cloudinaryUrl);

    Cloudinary() {
      cloudinaryUrl = Environment.cloudinaryUrlFromEnv() ?? (throw ArgumentError('A cloudinary url must be provided'));
    }
}
