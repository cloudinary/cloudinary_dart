import 'config/cloudinary_config.dart';
import 'util/environment.dart';
class Cloudinary {

  late CloudinaryConfig config;

    Cloudinary.withStringUrl(String cloudinaryUrl) {
      config = CloudinaryConfig.fromUri(cloudinaryUrl);
      // if(this.cloudinaryUrl == null) {
      //   Cloudinary();
      // }
    }

    Cloudinary.withConfiguration(this.config);

    Cloudinary() {
      String cloudinaryUrl = Environment.cloudinaryUrlFromEnv() ?? (throw ArgumentError('A cloudinary url must be provided'));
      config = CloudinaryConfig.fromUri(cloudinaryUrl);
    }
}
