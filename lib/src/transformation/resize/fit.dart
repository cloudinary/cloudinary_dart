// package com.cloudinary.transformation.resize
//
// class Fit(
// dimensions: Dimensions, relative: Boolean? = null,
// regionRelative: Boolean? = null
// ) :
// Resize(dimensions, relative, regionRelative) {
//   override val actionType = "fit"
//
//   class Builder : BaseBuilder<Builder>() {
//   override fun getThis() = this
//   override fun build() = Fit(
//   Dimensions(width, height, aspectRatio),
//   relative,
//   regionRelative
//   )
//   }
// }

import 'package:cloudinary_dart/src/transformation/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

/// Class Fit
class Fit extends Resize {
  @override
  String actionType = "fit";

  Fit(super.dimensions, {super.relative, super.regionRelative});
}

class FitBuilder extends BaseBuilder<FitBuilder> {
  FitBuilder({dynamic width, dynamic height}) {
    super.width(width);
    super.height(height);
  }

  @override
  Object getThis() {
    return this;
  }

  @override
  Action build() {
    return Fit(
        Dimensions(
            width: getWidth(),
            height: getHeight(),
            aspectRatio: getAspectRatio()),
        relative: getRelative(),
        regionRelative: getRegionRelative());
  }

  @override
  void copyWith(other) {
    width(other.getWidth());
    height(other.getHeight());
    aspectRatio(other.getAspectRatio());
  }
}
