import 'package:cloudinary_dart/src/asset/asset.dart';

class Video extends BaseAsset {
  @override
  final String assetType = assetTypeVideo;
  Video.withBuilder(super.builder) : super.withBuilder();

  @override
  String getTransformationString() {
    return transformation ?? "";
  }
}