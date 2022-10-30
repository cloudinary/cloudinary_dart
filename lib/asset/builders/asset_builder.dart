import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../../transformation/transformation.dart';
import '../asset.dart';
import 'general_asset_builder.dart';

class AssetBuilder extends GeneralAssetBuilder {
  AssetBuilder(
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
    super.assetType('raw');
  }

  @override
  Asset build() {
    return Asset.withBuilder(this);
  }
}
