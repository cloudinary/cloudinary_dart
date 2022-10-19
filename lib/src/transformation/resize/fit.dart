import 'package:cloudinary_dart/src/transformation/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import 'common.dart';

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
  Fit build() {
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
