import 'asset/cld_image.dart';
import 'asset/cld_video.dart';
import 'config/cloudinary_config.dart';
import 'util/environment.dart';

import 'asset/cld_asset.dart';

String sdkVersion = '0.9.0';

class Cloudinary {
  late CloudinaryConfig config;

  static var userAgent = 'CloudinaryDart/$sdkVersion';

  Cloudinary.fromStringUrl(String cloudinaryUrl) {
    config = CloudinaryConfig.fromUri(cloudinaryUrl);
  }

  Cloudinary.fromCloudName({required String cloudName, String? apiKey}) {
    config = CloudinaryConfig.fromUri('cloudinary://$apiKey:@$cloudName');
  }

  Cloudinary.fromConfiguration(this.config);

  Cloudinary() {
    String cloudinaryUrl = Environment.cloudinaryUrlFromEnv() ??
        (throw ArgumentError('A cloudinary url must be provided'));
    config = CloudinaryConfig.fromUri(cloudinaryUrl);
  }

  /// Creates a new Raw instance using the current configuration instance.
  ///
  /// Receives publicId [String] The public ID of the file.
  /// return [CldAsset]
  CldAsset raw(String publicId) {
    CldAsset asset = CldAsset(publicId);
    asset.cloudConfig(config.cloudConfig);
    asset.urlConfig(config.urlConfig);
    return asset;
  }

  /// Creates a new Image instance using the current configuration instance.
  ///
  /// Receives publicId [String] The public ID of the image.
  /// return [CldImage]
  CldImage image(String publicId) {
    CldImage image = CldImage(publicId);
    image.cloudConfig(config.cloudConfig);
    image.urlConfig(config.urlConfig);
    return image;
  }

  /// Creates a new Video instance using the current configuration instance.
  ///
  /// Receives publicId [String] The public ID of the video.
  /// return [CldVideo]
  CldVideo video(String publicId) {
    CldVideo video = CldVideo(publicId);
    video.cloudConfig(config.cloudConfig);
    video.urlConfig(config.urlConfig);
    return video;
  }
}
