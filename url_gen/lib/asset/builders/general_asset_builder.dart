import '../../analytics/analytics.dart';
import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../../transformation/transformation.dart';

abstract class GeneralAsset {
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
  String? _signature;
  TransformationObject? _transformation;
  Analytics? _analytics;

  GeneralAsset(
      [this._cloudConfig,
      this._urlConfig,
      this._version,
      this._publicId,
      this._extension,
      this._urlSuffix,
      this._assetType,
      this._deliveryType,
      this._signature,
      this._transformation,
      this._analytics]);

  GeneralAsset cloudConfig(CloudConfig cloudConfig) {
    _cloudConfig = cloudConfig;
    return this;
  }

  GeneralAsset urlConfig(UrlConfig urlConfig) {
    _urlConfig = urlConfig;
    return this;
  }

  GeneralAsset version(dynamic version) {
    if (version is int) {
      _version = '$version';
    } else {
      _version = version;
    }
    return this;
  }

  GeneralAsset publicId(String publicId) {
    _publicId = publicId;
    return this;
  }

  GeneralAsset extension(String extension) {
    _extension = extension;
    return this;
  }

  GeneralAsset urlSuffix(String urlSuffix) {
    _urlSuffix = urlSuffix;
    return this;
  }

  GeneralAsset deliveryType(String deliveryType) {
    _deliveryType = deliveryType;
    return this;
  }

  GeneralAsset assetType(String assetType) {
    _assetType = assetType;
    return this;
  }

  GeneralAsset transformation(Transformation transformation) {
    _transformation = transformation.build();
    return this;
  }

  GeneralAsset signature(String signature) {
    _signature = signature;
    return this;
  }

  GeneralAsset analytics(Analytics analytics) {
    _analytics = analytics;
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

  String? getSignature() {
    return _signature;
  }

  Analytics? getAnalytics() {
    return _analytics;
  }

  TransformationObject? getTransformation() {
    return _transformation;
  }
}
