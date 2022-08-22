import '../../config/cloud_config.dart';
import '../../config/url_config.dart';
import '../asset.dart';

class AssetBuilder {
  //config
  late CloudConfig cloudConfig;
  late UrlConfig urlConfig;

  //fields
  String? version;
  String? publicId;

  //Format? extension;
  String? urlSuffix;
  String assetType = defaultAssetType;
  String? deliveryType;
}

