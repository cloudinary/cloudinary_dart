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

  Asset raw(String publicId) {
    Asset asset = Asset(publicId);
    asset.cloudConfig(config.cloudConfig);
    asset.urlConfig(config.urlConfig);
    return asset;
  }

  Image image(String publicId) {
    Image image = Image(publicId);
    image.cloudConfig(config.cloudConfig);
    image.urlConfig(config.urlConfig);
    return image;
  }

  Video video(String publicId) {
    Video video = Video(publicId);
    video.cloudConfig(config.cloudConfig);
    video.urlConfig(config.urlConfig);
    return video;
  }
}
