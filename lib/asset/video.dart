import 'package:cloudinary_dart/asset/asset.dart';

class Video extends BaseAsset {
  Video.withBuilder(super.builder) : super.withBuilder();

  @override
  String getTransformationString() {
    return (transformation != null) ? transformation.toString() : '';
  }
}
