import '../common.dart';
import '../gravity/gravity.dart';
import 'resize.dart';

/// Class BaseFill
abstract class BaseFill extends Resize {
  Gravity? _gravity;
  dynamic _x;
  dynamic _y;

  BaseFill(
      {super.dimensions,
      super.relative,
      super.regionRelative,
      Gravity? gravityValue,
      dynamic xValue,
      dynamic yValue}) {
    if (gravityValue != null) {
      gravity(gravityValue);
    }
    x(xValue);
    y(yValue);
  }

  /// Sets the gravity.
  /// Receives [Gravity] returns this [BaseFill]
  BaseFill gravity(Gravity gravity) {
    _gravity = gravity;
    return this;
  }

  /// Sets the x value.
  /// Receives [dynamic] returns this [BaseFill]
  BaseFill x(dynamic x) {
    _x = x;
    return this;
  }

  /// Sets the y value.
  /// Receives [dynamic] returns this [BaseFill]
  BaseFill y(dynamic y) {
    _y = y;
    return this;
  }

  @override
  List<Param?> params() {
    var params = super.params();
    params.add((_gravity != null) ? Param('g', _gravity) : null);
    params.add((_x != null) ? Param('x', _x) : null);
    params.add((_y != null) ? Param('y', _y) : null);
    return params;
  }
}

/// Class Fill
class Fill extends BaseFill {
  @override
  String actionType = "fill";
}

/// Class LimitFill
class LimitFill extends BaseFill {
  @override
  String actionType = "lfill";
}
