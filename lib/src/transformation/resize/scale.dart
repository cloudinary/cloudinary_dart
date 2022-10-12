import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import '../common.dart';

class Scale extends Resize {

  bool? liquidRescaling;

  @override
  String actionType = "scale";

  Scale(super.dimensions, {super.relative, super.regionRelative, this.liquidRescaling = false});

  @override
  List<Param?> params() {
    var params = super.params();
    params.add((liquidRescaling == true) ? Param("g", "liquid") : null);
    return params;
  }
}

class ScaleBuilder extends BaseBuilder<ScaleBuilder> {
  bool? liquidRescaling;

  ScaleBuilder setLiquidRescaling({bool? liquidRescaling}) {
    this.liquidRescaling = liquidRescaling;
    return this;
  }

  @override
  Object getThis() {
    return this;
  }

  @override
  Action build() {
    return Scale(Dimensions(width: width, height: height, aspectRatio: aspectRatio), relative: relative, regionRelative: regionRelative, liquidRescaling: liquidRescaling);
  }

  @override
  void copyWith(other) {
    width = other.width;
    height = other.height;
    aspectRatio = other.aspectRatio;
    relative = other.relative;
    regionRelative = other.regionRelative;
    liquidRescaling = other.liquidRescaling;
  }
}