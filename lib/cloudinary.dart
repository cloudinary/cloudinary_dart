import 'package:cloudinary_dart/asset/builders/video_builder.dart';

import 'asset/builders/asset_builder.dart';
import 'asset/builders/image_builder.dart';
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

  Asset raw(String publicId, [AssetBuilder? options]) {
    var builder = AssetBuilder()
      ..publicId(publicId)
      ..cloudConfig(config.cloudConfig)
      ..urlConfig(config.urlConfig)
      ..assetType('raw');
    if (options != null) {
      builder.combineWith(options);
    }
    return Asset.withBuilder(builder);
  }

  Image image(String publicId, [ImageBuilder? options]) {
    var builder = ImageBuilder()
      ..publicId(publicId)
      ..cloudConfig(config.cloudConfig)
      ..urlConfig(config.urlConfig)
      ..assetType('image');
    if (options != null) {
      builder.combineWith(options);
    }
    return Image.withBuilder(builder);
  }

  Video video(String publicId, [VideoBuilder? options]) {
    var builder = VideoBuilder()
      ..publicId(publicId)
      ..cloudConfig(config.cloudConfig)
      ..urlConfig(config.urlConfig)
      ..assetType('video');
    if (options != null) {
      builder.combineWith(options);
    }
    return Video.withBuilder(builder);
  }
}
