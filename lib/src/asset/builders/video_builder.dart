import '../video.dart';
import 'general_asset_builder.dart';

class VideoBuilder extends GeneralAssetBuilder {
  @override
  String assetType = 'video';
  @override
  Video build() {
    return Video.withBuilder(this);
  }
}