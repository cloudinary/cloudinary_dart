import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../../transformation/transformation.dart';

abstract class GeneralAssetBuilder {
  //config
  CloudConfig? _cloudConfig;
  UrlConfig? _urlConfig = UrlConfig();

  //fields
  String? _version;
  String? _publicId;

  String? _extension;
  String? _urlSuffix;
  String? _assetType;
  String? _deliveryType;
  TransformationObject? _transformation;

  GeneralAssetBuilder(
      [this._cloudConfig,
      this._urlConfig,
      this._version,
      this._publicId,
      this._extension,
      this._urlSuffix,
      this._assetType,
      this._deliveryType,
      this._transformation]);

  GeneralAssetBuilder cloudConfig(CloudConfig cloudConfig) {
    _cloudConfig = cloudConfig;
    return this;
  }

  GeneralAssetBuilder urlConfig(UrlConfig urlConfig) {
    _urlConfig = urlConfig;
    return this;
  }

  GeneralAssetBuilder version(String version) {
    _version = version;
    return this;
  }

  GeneralAssetBuilder publicId(String publicId) {
    _publicId = publicId;
    return this;
  }

  GeneralAssetBuilder extension(String extension) {
    _extension = extension;
    return this;
  }

  GeneralAssetBuilder urlSuffix(String urlSuffix) {
    _urlSuffix = urlSuffix;
    return this;
  }

  GeneralAssetBuilder deliveryType(String deliveryType) {
    _deliveryType = deliveryType;
    return this;
  }

  GeneralAssetBuilder assetType(String assetType) {
    _assetType = assetType;
    return this;
  }

  GeneralAssetBuilder transformation(Transformation transformation) {
    _transformation = transformation.build();
    return this;
  }

  CloudConfig? getCloudConfig() {
    return _cloudConfig;
  }

  UrlConfig? getUrlConfig() {
    return _urlConfig;
  }

  String? getVersion() {
    return _version;
  }

  String? getPublicId() {
    return _publicId;
  }

  String? getExtension() {
    return _extension;
  }

  String? getUrlSuffix() {
    return _urlSuffix;
  }

  String? getAssetType() {
    return _assetType;
  }

  String? getDeliveryType() {
    return _deliveryType;
  }

  TransformationObject? getTransformation() {
    return _transformation;
  }
}
