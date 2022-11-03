import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../../src/transformation/transformation.dart';
import '../video.dart';
import 'general_asset_builder.dart';

class Video extends GeneralAssetBuilder {
  Video(
      {CloudConfig? cloudConfig,
      UrlConfig? urlConfig,
      String? version,
      String? publicId,
      String? extension,
      String? urlSuffix,
      String? assetType,
      String? deliveryType,
      TransformationObject? transformation})
      : super(cloudConfig, urlConfig, version, publicId, extension, urlSuffix,
            assetType, deliveryType, transformation) {
    super.assetType('video');
  }

  @override
  VideoObject build() {
    return VideoObject.withBuilder(this);
  }
}
