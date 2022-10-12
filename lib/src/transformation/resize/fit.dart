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

class Fit extends Resize {
  @override
  String actionType = "fit";

  Fit(super.dimensions, {super.relative, super.regionRelative});
}

class FitBuilder extends BaseBuilder<FitBuilder> {

  @override
  Object getThis() {
    return this;
  }
  @override
  Action build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void copyWith(other) {
    width = other.width;
    height = other.height;
    aspectRatio = other.aspectRatio;
  }

}