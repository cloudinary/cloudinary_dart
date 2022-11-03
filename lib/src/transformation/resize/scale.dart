import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import '../common.dart';

abstract class BaseScale extends Resize {
  BaseScale({super.dimensions, super.relative, super.regionRelative});

  @override
  List<Param?> params() {
    var params = super.params();
    return params;
  }
}

class Scale extends BaseScale {
  @override
  String actionType = "scale";

  bool? _liquidRescaling;

  Scale(
      {super.dimensions,
      super.relative,
      super.regionRelative,
      bool? liquidRescalingValue = false}) {
    liquidRescaling(liquidRescalingValue);
  }

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
  List<Param?> params() {
    var params = super.params();
    params.add((_liquidRescaling == true) ? Param("g", "liquid") : null);
    return params;
  }
}
