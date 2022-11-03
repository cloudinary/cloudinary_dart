import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import '../common.dart';
import '../gravity/gravity.dart';

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

  BaseFill gravity(Gravity gravity) {
    _gravity = gravity;
    return this;
  }

  BaseFill x(dynamic x) {
    _x = x;
    return this;
  }

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

class Fill extends BaseFill {
  @override
  String actionType = "fill";
}

class LimitFill extends BaseFill {
  @override
  String actionType = "lfill";
}
