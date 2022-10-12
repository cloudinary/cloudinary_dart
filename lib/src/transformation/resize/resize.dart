import 'package:cloudinary_dart/src/transformation/TransformationUtils.dart';
import 'package:cloudinary_dart/src/transformation/resize/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/scale.dart';

import '../common.dart';

class Dimensions {
  dynamic width;
  dynamic height;
  dynamic aspectRatio;

  Dimensions({this.width, this.height, this.aspectRatio});
}

abstract class Resize extends Action {
  Dimensions dimensions;
  bool? relative;
  bool? regionRelative;
  abstract String actionType;

  Resize(this.dimensions, {this.relative, this.regionRelative});

  @override
  String toString() {
    return toComponentString(params());
  }

  List<Param?> params() {
      return [Param("c", actionType),
        (dimensions.width != null) ? Param("w", dimensions.width) : null,
        (dimensions.height != null) ? Param("h", dimensions.height): null,
        (relative == true) ? Param("fl","relative") : null,
        (regionRelative == true) ? Param("fl", "region_relative") : null,
        (dimensions.aspectRatio == AspectRatio.ignoreInitialAspectRatio)
            ? Param("fl", "ignore_aspect_ratio") : (dimensions.aspectRatio != null) ? Param("ar", dimensions.aspectRatio) : null
      ];
  }

  static Resize scale({int? width, int? height, ScaleBuilder? options}) {
    var builder = ScaleBuilder();
    builder.setWidth(width);
    builder.setHeight(height);
    if (options != null) { builder.copyWith(options); }
    return builder.build() as Resize;
  }


}