import 'asset/image.dart';
import 'asset/video.dart';
import 'config/cloudinary_config.dart';
import 'src/util/environment.dart';

import 'asset/asset.dart';

final sdkVersion = '0.0.1';

class Cloudinary {
  late CloudinaryConfig config;

  var userAgent = 'CloudinaryFlutter/$sdkVersion';

  Cloudinary.withStringUrl(String cloudinaryUrl) {
    config = CloudinaryConfig.fromUri(cloudinaryUrl);
  }

  Cloudinary.withConfiguration(this.config);

  Cloudinary() {
    String cloudinaryUrl = Environment.cloudinaryUrlFromEnv() ??
        (throw ArgumentError('A cloudinary url must be provided'));
    config = CloudinaryConfig.fromUri(cloudinaryUrl);
  }

  AssetObject raw(Asset options) {
    options.cloudConfig(config.cloudConfig);
    options.urlConfig(config.urlConfig);
    return AssetObject.withBuilder(options);
  }

  ImageObject image(Image options) {
    options.cloudConfig(config.cloudConfig);
    options.urlConfig(config.urlConfig);
    return ImageObject.withBuilder(options);
  }

  VideoObject video(Video options) {
    options.cloudConfig(config.cloudConfig);
    options.urlConfig(config.urlConfig);
    return VideoObject.withBuilder(options);
  }

  Cloudinary clone() {
    Cloudinary cloudinary = Cloudinary.withConfiguration(config);
    cloudinary.userAgent = userAgent;
    return cloudinary;
  }
}
