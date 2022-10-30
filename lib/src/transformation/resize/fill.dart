import 'package:cloudinary_dart/src/transformation/resize/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import '../common.dart';
import '../gravity/gravity.dart';

class FillObject extends Resize {
  Gravity? gravity;
  dynamic x;
  dynamic y;

  @override
  String actionType = "fill";


  FillObject(super.dimensions,
      {super.relative,
        super.regionRelative,
        this.gravity,
        this.x,
        this.y});

  @override
  List<Param?> params() {
    var params = super.params();
    params.add((gravity != null) ? Param('g', gravity) : null);
    params.add((x != null) ? Param('x', x) : null);
    params.add((y != null) ? Param('y', y) : null);
    return params;
  }
}

class Fill extends BaseBuilder<Fill> {
  Gravity? _gravity;
  dynamic _x;
  dynamic _y;

  Fill gravity(Gravity gravity) {
    _gravity = gravity;
    return this;
  }

  Fill x(dynamic x) {
    _x = x;
    return this;
  }

  Fill y(dynamic y) {
    _y = y;
    return this;
  }

  @override
  Object getThis() {
    return this;
  }

  @override
  FillObject build() {
    return FillObject(
        Dimensions(
            width: getWidth(),
            height: getHeight(),
            aspectRatio: getAspectRatio()),
        gravity: _gravity,
        x: _x,
        y: _y);
  }

  @override
  void copyWith(other) {
    width(other.getWidth());
    height(other.getHeight());
    aspectRatio(other.getAspectRatio());
    relative(other.getRelative());
    regionRelative(other.getRegionRelative());
    _gravity = other._gravity;
    _x = other._x;
    _y = other._y;
  }
}