/// Cloudinary URL Generation Library
///
/// A Dart SDK for generating Cloudinary URLs with transformations.
library cloudinary;

// Core
export 'src/analytics/analytics.dart';
export 'src/asset/cld_image.dart';
export 'src/asset/cld_video.dart';
export 'src/asset/cld_asset.dart';
export 'src/config/cloudinary_config.dart';
export 'src/config/cloud_config.dart';
export 'src/config/url_config.dart';
export 'src/config/api_config.dart';
export 'util/environment.dart';

// Transformation
export 'src/transformation/transformation.dart';
export 'src/transformation/border.dart';
export 'src/transformation/color.dart';
export 'src/transformation/common.dart';
export 'src/transformation/flag.dart';
export 'src/transformation/named_transformation.dart';
export 'src/transformation/region.dart';
export 'src/transformation/rotate.dart';
export 'src/transformation/round_corners.dart';
export 'src/transformation/transformation_utils.dart';

// Transformation sub-packages
export 'src/transformation/adjust/adjust.dart';
export 'src/transformation/background/background.dart';
export 'src/transformation/coordinates/coordinates.dart';
export 'src/transformation/delivery/delivery.dart';
export 'src/transformation/effect/effect.dart';
export 'src/transformation/extract/extract.dart';
export 'src/transformation/gravity/gravity.dart';
export 'src/transformation/layer/common.dart';
export 'src/transformation/reshape/reshape.dart';
export 'src/transformation/resize/resize.dart';
export 'src/transformation/source/source.dart';
export 'src/transformation/video_edit/video_edit.dart';

// Asset Builders
export 'src/asset/builders/general_asset_builder.dart';

import 'src/analytics/analytics.dart';
import 'src/asset/cld_image.dart';
import 'src/asset/cld_video.dart';
import 'src/config/cloudinary_config.dart';
import 'util/environment.dart';

import 'src/asset/cld_asset.dart';

String sdkVersion = '2.0.0';

class Cloudinary {
  late CloudinaryConfig config;

  static var userAgent = 'CloudinaryDart/$sdkVersion';

  Analytics analytics = Analytics();

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
    asset.analytics(analytics);
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
    image.analytics(analytics);
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
    video.analytics(analytics);
    return video;
  }

  setAnalytics(Analytics analytics) {
    this.analytics = analytics;
  }
}
