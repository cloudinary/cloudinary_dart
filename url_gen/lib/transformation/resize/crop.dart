import '../common.dart';
import '../gravity/gravity.dart';
import 'resize.dart';

/// Class BaseCrop
abstract class BaseCrop extends Resize {
  Gravity? _gravity;
  dynamic _zoom;
  dynamic _x;
  dynamic _y;

  /// Crop constructor
  /// Receives [Dimensions],
  /// [relative],
  /// [regionRelative],
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

  /// Sets the gravity
  /// Receives [Gravity] returns this object [BaseCrop]
  BaseCrop gravity(Gravity gravity) {
    _gravity = gravity;
    return this;
  }

  /// Sets the zoom
  /// Receives [dynamic] returns this object [BaseCrop]
  BaseCrop zoom(dynamic zoom) {
    _zoom = zoom;
    return this;
  }

  /// Sets the x value
  /// Receives [dynamic] returns this object [BaseCrop]
  BaseCrop x(dynamic x) {
    _x = x;
    return this;
  }

  /// Sets the y value
  /// Receives [dynamic] returns this object [BaseCrop]
  BaseCrop y(dynamic y) {
    _y = y;
    return this;
  }

  @override
  List<Param?> params() {
    var params = super.params();
    params.add((_gravity != null) ? Param('g', _gravity) : null);
    params.add((_x != null) ? Param('x', _x) : null);
    params.add((_y != null) ? Param('y', _y) : null);
    params.add((_zoom != null) ? Param('z', _zoom) : null);
    return params;
  }
}

/// Class Crop
class Crop extends BaseCrop {
  @override
  String actionType = "crop";
}

class Thumbnail extends BaseCrop {
  @override
  String actionType = "thumb";
}
