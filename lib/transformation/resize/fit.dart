import 'package:cloudinary_dart/transformation/resize/resize.dart';
import 'package:cloudinary_dart/transformation/resize/scale.dart';

import '../common.dart';

/// Class FitObject
class FitObject extends BaseScale {
  @override
  String actionType = "fit";

  FitObject(super.dimensions, {super.relative, super.regionRelative});
}

/// Class Fit
class Fit extends BaseScaleBuilder {
  @override
  FitObject build() {
    return FitObject(
        Dimensions(
            width: super.getWidth(),
            height: super.getHeight(),
            aspectRatio: super.getAspectRatio()),
        relative: super.getRelative(),
        regionRelative: super.getRegionRelative());
  }
}

/// Class LimitFitObject
class LimitFitObject extends BaseScale {
  @override
  String actionType = "limit";

  LimitFitObject(super.dimensions, {super.relative, super.regionRelative});
}

/// Class LimitFit
class LimitFit extends BaseScaleBuilder {
  @override
  LimitFitObject build() {
    return LimitFitObject(
        Dimensions(
            width: super.getWidth(),
            height: super.getHeight(),
            aspectRatio: super.getAspectRatio()),
        relative: super.getRelative(),
        regionRelative: super.getRegionRelative());
  }
}

/// Class MinimumFitObject
class MinimumFitObject extends BaseScale {
  @override
  String actionType = "mfit";

  MinimumFitObject(super.dimensions, {super.relative, super.regionRelative});
}

/// Class MinimumFit
class MinimumFit extends BaseScaleBuilder {
  @override
  MinimumFitObject build() {
    return MinimumFitObject(
        Dimensions(
            width: super.getWidth(),
            height: super.getHeight(),
            aspectRatio: super.getAspectRatio()),
        relative: super.getRelative(),
        regionRelative: super.getRegionRelative());
  }
}
