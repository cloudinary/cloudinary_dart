import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../asset.dart';
import '../format.dart';

abstract class GeneralAssetBuilder {
  //config
  late CloudConfig cloudConfig;
  late UrlConfig urlConfig;

  //fields
  String? version;
  String? publicId;

  Format? extension;
  String? urlSuffix;
  late String assetType;
  String? deliveryType;

  dynamic build() {
    return Asset.withBuilder(this);
  }

  dynamic setCloudConfig(CloudConfig cloudConfig) {
    this.cloudConfig = cloudConfig;
    return this;
  }

  dynamic setUrlConfig(UrlConfig urlConfig) {
    this.urlConfig = urlConfig;
    return this;
  }

  dynamic setVersion(String version) {
    this.version = version;
    return this;
  }

  dynamic setPublicId(String publicId) {
    this.publicId = publicId;
    return this;
  }

  dynamic setUrlSuffix(String urlSuffix) {
    this.urlSuffix = urlSuffix;
    return this;
  }

  dynamic setExtension(Format extension) {
    this.extension = extension;
    return this;
  }

  dynamic setAssetType(String assetType) {
    this.assetType = assetType;
    return this;
  }

  dynamic setDeliveryType(String deliveryType) {
    this.deliveryType = deliveryType;
    return this;
  }

  void combineWith(GeneralAssetBuilder other) {
      version = other.version ?? version;
      publicId = other.publicId ?? publicId;
      extension = other.extension ?? extension;
      urlSuffix = other.urlSuffix ?? urlSuffix;
      assetType = other.assetType;
      deliveryType = other.deliveryType ?? deliveryType;
  }
}

