import 'config/cloudinary_config.dart';
import 'util/environment.dart';

import 'asset/asset.dart';

final sdkVersion = '0.0.1';

class Cloudinary {
  late CloudinaryConfig config;

  var userAgent = 'CloudinaryFlutter/$sdkVersion';

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

    Asset raw({AssetBuilder? options}) {
      if (options != null) {
        return Asset.withBuilder(options);
      } else {
        var builder = AssetBuilder() ..cloudConfig = config.cloudConfig ..urlConfig = config.urlConfig ..assetType = "raw";
        return Asset.withBuilder(builder);
      }
    }


}
