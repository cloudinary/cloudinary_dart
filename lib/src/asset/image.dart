import 'package:cloudinary_dart/src/asset/asset.dart';

class Image extends BaseAsset {
  Image.withBuilder(super.builder) : super.withBuilder();

  @override
  String getTransformationString() {
    return transformation ?? "";
  }
}
