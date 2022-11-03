import 'package:cloudinary_dart/src/transformation/transformation.dart';

import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../image.dart';
import 'general_asset_builder.dart';

class Image extends GeneralAssetBuilder {
  Image(
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
    super.assetType('image');
  }

  @override
  ImageObject build() {
    return ImageObject.withBuilder(this);
  }
}
