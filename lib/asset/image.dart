import 'package:cloudinary_dart/asset/asset.dart';

import '../transformation/transformation.dart';

class Image extends BaseAsset {
  Image.withBuilder(super.builder) : super.withBuilder();

  @override
  String getTransformationString() {
    return (transformation != null) ? transformation.toString() : '';
  }

  @override
  TransformationObject? getTransformation() {
    return transformation;
  }
}
