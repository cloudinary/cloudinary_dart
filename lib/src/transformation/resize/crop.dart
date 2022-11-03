import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import '../common.dart';
import '../gravity/gravity.dart';

/// Class CropObject
abstract class BaseCrop extends Resize {
  Gravity? _gravity;
  dynamic _zoom;
  dynamic _x;
  dynamic _y;

  /// Crop constructor
  /// Receives [Dimensions],
  /// [relative],
  /// [relativeRegion],
  /// [gravity],
  /// [zoom],
  /// [x],
  /// [y]
  BaseCrop(
      {super.dimensions,
      super.relative,
      super.regionRelative,
      Gravity? gravityValue,
      dynamic zoomValue,
      dynamic xValue,
      dynamic yValue}) {
    if (gravityValue != null) {
      gravity(gravityValue);
    }
    if (zoomValue != null) {
      zoom(zoomValue);
    }
    if (xValue != null) {
      x(xValue);
    }
    if (yValue != null) {
      y(yValue);
    }
  }

  BaseCrop gravity(Gravity gravity) {
    _gravity = gravity;
    return this;
  }

  BaseCrop zoom(dynamic zoom) {
    _zoom = zoom;
    return this;
  }

  BaseCrop x(dynamic x) {
    _x = x;
    return this;
  }

  BaseCrop y(dynamic y) {
    _y = y;
    return this;
  }
}

/// Class Crop
class Crop extends BaseCrop {
  @override
  String actionType = "crop";

  @override
  List<Param?> params() {
    var params = super.params();
    params.add((_gravity != null) ? Param('g', _gravity) : null);
    params.add((_x != null) ? Param('x', x) : null);
    params.add((_y != null) ? Param('y', y) : null);
    params.add((_zoom != null) ? Param('z', _zoom) : null);
    return params;
  }
}
