import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../asset.dart';
import '../format.dart';
import 'general_asset_builder.dart';

class AssetBuilder extends GeneralAssetBuilder {
  AssetBuilder(
      {CloudConfig? cloudConfig,
      UrlConfig? urlConfig,
      String? version,
      String? publicId,
      Format? extension,
      String? urlSuffix,
      String? assetType,
      String? deliveryType,
      String? transformation})
      : super(cloudConfig, urlConfig, version, publicId, extension, urlSuffix,
            assetType, deliveryType, transformation) {
    super.assetType = 'raw';
  }

  @override
  Asset build() {
    return Asset.withBuilder(this);
  }
}
