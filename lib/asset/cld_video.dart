import 'package:cloudinary_dart/asset/cld_asset.dart';

import '../config/cloud_config.dart';
import '../config/url_config.dart';
import '../transformation/transformation.dart';
import 'builders/general_asset_builder.dart';

class CldVideo extends GeneralAsset {
  CldVideo(String publicId,
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
  String toString() {
    return VideoObject.withBuilder(this).toString();
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
