import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../asset.dart';
import '../format.dart';

abstract class GeneralAssetBuilder {
  //config
   CloudConfig? cloudConfig;
   UrlConfig? urlConfig = UrlConfig();

  //fields
  String? version;
  String? publicId;

  Format? extension;
  String? urlSuffix;
  String? assetType;
  String? deliveryType;

  GeneralAssetBuilder([this.cloudConfig, this.urlConfig, this.version, this.publicId, this.extension, this.urlSuffix, this.assetType, this.deliveryType]);

  void combineWith(GeneralAssetBuilder other) {
      version = other.version ?? version;
      publicId = other.publicId ?? publicId;
      extension = other.extension ?? extension;
      urlSuffix = other.urlSuffix ?? urlSuffix;
      assetType = other.assetType;
      deliveryType = other.deliveryType ?? deliveryType;
  }

   dynamic build() {
     return Asset.withBuilder(this);
   }
}

