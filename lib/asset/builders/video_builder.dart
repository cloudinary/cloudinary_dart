import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../video.dart';
import 'general_asset_builder.dart';

class VideoBuilder extends GeneralAssetBuilder {
  VideoBuilder(
      {CloudConfig? cloudConfig,
      UrlConfig? urlConfig,
      String? version,
      String? publicId,
      String? extension,
      String? urlSuffix,
      String? assetType,
      String? deliveryType,
      String? transformation})
      : super(cloudConfig, urlConfig, version, publicId, extension, urlSuffix,
            assetType, deliveryType, transformation) {
    super.assetType = 'video';
  }

  @override
  Video build() {
    return Video.withBuilder(this);
  }
}
