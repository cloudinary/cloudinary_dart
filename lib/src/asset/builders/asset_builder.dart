import '../asset.dart';
import 'general_asset_builder.dart';

class AssetBuilder extends GeneralAssetBuilder {
  @override
  String assetType = 'raw';
  @override
  Asset build() {
    return Asset.withBuilder(this);
  }
}

