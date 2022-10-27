import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import '../common.dart';
import 'common.dart';

/// Class scale
class ScaleObject extends Resize {
  bool? liquidRescaling;

  @override
  String actionType = "scale";

  ScaleObject(super.dimensions,
      {super.relative, super.regionRelative, this.liquidRescaling = false});

  @override
  List<Param?> params() {
    var params = super.params();
    params.add((liquidRescaling == true) ? Param("g", "liquid") : null);
    return params;
  }
}

class Scale extends BaseBuilder<Scale> {
  bool? _liquidRescaling;

  /// Changes the aspect ratio of an image while retaining all important content and avoiding unnatural distortions.
  ///
  /// Liquid Rescaling is only supported for Scale mode.
  ///
  /// @return $this
  ///
  /// @see \Cloudinary\Transformation\LiquidRescaling
  Scale liquidRescaling([bool? liquidRescaling]) {
    _liquidRescaling = liquidRescaling;
    return this;
  }

  @override
  Object getThis() {
    return this;
  }

  @override
  Action build() {
    return ScaleObject(
        Dimensions(
            width: getWidth(),
            height: getHeight(),
            aspectRatio: getAspectRatio()),
        relative: getRelative(),
        regionRelative: getRegionRelative(),
        liquidRescaling: _liquidRescaling);
  }

  @override
  void copyWith(other) {
    width(other.getWidth());
    height(other.getHeight());
    aspectRatio(other.getAspectRatio());
    relative(other.getRelative());
    regionRelative(other.getRegionRelative());
    _liquidRescaling = (other._liquidRescaling);
  }
}
