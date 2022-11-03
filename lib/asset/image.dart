import 'package:cloudinary_dart/asset/asset.dart';

import '../src/transformation/transformation.dart';

class ImageObject extends BaseAsset {
  ImageObject.withBuilder(super.builder) : super.withBuilder();

  @override
  String getTransformationString() {
    return (transformation != null) ? transformation.toString() : '';
  }

  @override
  TransformationObject? getTransformation() {
    return transformation;
  }
}
