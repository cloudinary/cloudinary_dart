import 'package:cloudinary_dart/asset/asset.dart';
import 'package:cloudinary_dart/transformation/transformation.dart';

import '../config/cloud_config.dart';
import '../config/url_config.dart';
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
  String toString() {
    return ImageObject.withBuilder(this).toString();
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
