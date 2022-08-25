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

  void combineWith(GeneralAssetBuilder other) {
      version = other.version ?? version;
      publicId = other.publicId ?? publicId;
      extension = other.extension ?? extension;
      urlSuffix = other.urlSuffix ?? urlSuffix;
      assetType = other.assetType;
      deliveryType = other.deliveryType ?? deliveryType;
  }
}

