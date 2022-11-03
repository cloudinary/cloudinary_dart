import 'package:cloudinary_dart/src/transformation/transformation.dart';

import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../asset.dart';
import 'general_asset_builder.dart';

class Asset extends GeneralAssetBuilder {
  Asset(String publicId,
      {CloudConfig? cloudConfig,
      UrlConfig? urlConfig,
      String? version,
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
  AssetObject build() {
    return AssetObject.withBuilder(this);
  }
}
