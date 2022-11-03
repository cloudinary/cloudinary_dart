import 'package:cloudinary_dart/src/transformation/gravity/gravity.dart';
import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import '../background/background.dart';
import '../common.dart';

abstract class BasePad extends Resize {
  Gravity? _gravity;
  dynamic _offsetX;
  dynamic _offsetY;
  Background? _background;

  BasePad(
      {super.dimensions,
      super.relative,
      super.regionRelative,
      CompassGravity? gravityValue,
      dynamic offsetXValue,
      dynamic offsetYValue,
      Background? backgroundValue}) {
    if (gravityValue != null) {
      gravity(gravityValue);
    }
    offsetX(offsetXValue);
    offsetY(offsetYValue);
    if (backgroundValue != null) {
      background(backgroundValue);
    }
  }

  BasePad background(Background background) {
    _background = background;
    return this;
  }

  BasePad offsetX(dynamic offsetX) {
    _offsetX = offsetX;
    return this;
  }

  BasePad offsetY(dynamic offsetX) {
    _offsetX = offsetX;
    return this;
  }

  BasePad gravity(CompassGravity gravity) {
    _gravity = gravity;
    return this;
  }

  @override
  List<Param?> params() {
    var params = super.params();
    params.add((_background != null) ? Param('b', _background) : null);
    params.add((_gravity != null) ? Param('g', _gravity) : null);
    params.add((_offsetX != null) ? Param('x', _offsetX) : null);
    params.add((_offsetY != null) ? Param('y', _offsetY) : null);
    return params;
  }
}

class Pad extends BasePad {
  @override
  String actionType = "pad";
}

class LimitPad extends BasePad {
  @override
  String actionType = 'lpad';
}

class MinimumPad extends BasePad {
  @override
  String actionType = 'mpad';
}
