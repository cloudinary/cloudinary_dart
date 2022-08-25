import '../image.dart';
import 'general_asset_builder.dart';

class ImageBuilder extends GeneralAssetBuilder {
  @override
  String assetType = 'image';
  @override
  Image build() {
      return Image.withBuilder(this);
    }
}