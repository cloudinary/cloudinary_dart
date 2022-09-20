import 'package:cloudinary_dart/src/asset/asset.dart';

class Video extends BaseAsset {
  Video.withBuilder(super.builder) : super.withBuilder();

  @override
  String getTransformationString() {
    return transformation ?? "";
  }
}
