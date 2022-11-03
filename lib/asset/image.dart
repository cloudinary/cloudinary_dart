import 'package:cloudinary_dart/asset/asset.dart';

import '../config/cloud_config.dart';
import '../config/url_config.dart';
import '../src/transformation/transformation.dart';
import 'builders/general_asset_builder.dart';

class Image extends GeneralAssetBuilder {
  Image(String? publicId,
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
    super.assetType('image');
  }

  @override
  ImageObject build() {
    return ImageObject.withBuilder(this);
  }
}

class ImageObject extends BaseAsset {
  ImageObject.withBuilder(super.builder) : super.withBuilder();

  @override
  String getTransformationString() {
    return (transformation != null) ? transformation.toString() : '';
  }

  @override
  TransformationObject? getTransformation() {
    return transformation;
  }
}
