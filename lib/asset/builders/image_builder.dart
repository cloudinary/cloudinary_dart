import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../image.dart';
import 'general_asset_builder.dart';

class ImageBuilder extends GeneralAssetBuilder {
  ImageBuilder(
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
    super.assetType = 'image';
  }

  @override
  Image build() {
    return Image.withBuilder(this);
  }
}
