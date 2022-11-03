import 'package:cloudinary_dart/asset/asset.dart';
import 'package:cloudinary_dart/src/transformation/transformation.dart';

class VideoObject extends BaseAsset {
  VideoObject.withBuilder(super.builder) : super.withBuilder();

  @override
  String getTransformationString() {
    return (transformation != null) ? transformation.toString() : '';
  }

  @override
  TransformationObject? getTransformation() {
    return transformation;
  }
}
