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

  CldAsset raw(String publicId) {
    CldAsset asset = CldAsset(publicId);
    asset.cloudConfig(config.cloudConfig);
    asset.urlConfig(config.urlConfig);
    return asset;
  }

  CldImage image(String publicId) {
    CldImage image = CldImage(publicId);
    image.cloudConfig(config.cloudConfig);
    image.urlConfig(config.urlConfig);
    return image;
  }

  CldVideo video(String publicId) {
    CldVideo video = CldVideo(publicId);
    video.cloudConfig(config.cloudConfig);
    video.urlConfig(config.urlConfig);
    return video;
  }
}
