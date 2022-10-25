import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../asset.dart';

abstract class GeneralAssetBuilder {
  //config
  CloudConfig? cloudConfig;
  UrlConfig? urlConfig = UrlConfig();

  //fields
  String? version;
  String? publicId;

  String? extension;
  String? urlSuffix;
  String? assetType;
  String? deliveryType;
  String? transformation;

  GeneralAssetBuilder(
      [this.cloudConfig,
      this.urlConfig,
      this.version,
      this.publicId,
      this.extension,
      this.urlSuffix,
      this.assetType,
      this.deliveryType,
      this.transformation]);

  void combineWith(GeneralAssetBuilder other) {
    version = other.version ?? version;
    publicId = other.publicId ?? publicId;
    extension = other.extension ?? extension;
    urlSuffix = other.urlSuffix ?? urlSuffix;
    assetType = other.assetType;
    deliveryType = other.deliveryType ?? deliveryType;
    transformation = other.transformation ?? transformation;
  }

  dynamic build() {
    return Asset.withBuilder(this);
  }
}
