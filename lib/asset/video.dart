import 'package:cloudinary_dart/asset/asset.dart';
import 'package:cloudinary_dart/src/transformation/transformation.dart';

import '../config/cloud_config.dart';
import '../config/url_config.dart';
import 'builders/general_asset_builder.dart';

class Video extends GeneralAssetBuilder {
  Video(String publicId,
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
    super.assetType('video');
  }

  @override
  VideoObject build() {
    return VideoObject.withBuilder(this);
  }
}

class VideoObject extends BaseAsset {
  VideoObject.withBuilder(super.builder) : super.withBuilder();

  @override
  String getTransformationString() {
    return (transformation != null) ? transformation.toString() : '';
  }

  @override
  TransformationObject? getTransformation() {
    return transformation;
  }
}
