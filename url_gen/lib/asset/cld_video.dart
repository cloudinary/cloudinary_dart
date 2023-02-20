import '../config/cloud_config.dart';
import '../config/url_config.dart';
import '../transformation/transformation.dart';
import 'builders/general_asset_builder.dart';
import 'cld_asset.dart';

class CldVideo extends GeneralAsset {
  CldVideo(String publicId,
      {CloudConfig? cloudConfig,
      UrlConfig? urlConfig,
      String? version,
      String? extension,
      String? urlSuffix,
      String? assetType,
      String? deliveryType,
      String? signature,
      TransformationObject? transformation})
      : super(cloudConfig, urlConfig, version, publicId, extension, urlSuffix,
            assetType, deliveryType, signature, transformation) {
    super.assetType('video');
  }

  @override
  String toString() {
    return VideoObject.fromBuilder(this).toString();
  }
}

class VideoObject extends BaseAsset {
  VideoObject.fromBuilder(super.builder) : super.fromBuilder();

  @override
  String getTransformationString() {
    return (transformation != null) ? transformation.toString() : '';
  }

  @override
  TransformationObject? getTransformation() {
    return transformation;
  }
}
