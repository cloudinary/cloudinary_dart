import 'package:cloudinary_dart/src/transformation/resize/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import '../common.dart';
import '../gravity/gravity.dart';

class BaseFillObject extends Resize {
  Gravity? gravity;
  dynamic x;
  dynamic y;

  @override
  String actionType = "fill";


  BaseFillObject(super.dimensions,
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

class Fill extends BaseBuilder<BaseFillObject> {
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
  BaseFillObject build() {
    return BaseFillObject(
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

class LimitFillObject extends BaseFillObject {
  @override
  String actionType = "lfill";

  LimitFillObject(super.dimensions,
  {super.relative,
  super.regionRelative,
    super.gravity,
    super.x,
    super.y});
}

class LimitFill extends Fill {
@override
  LimitFillObject build() {
    return LimitFillObject(
        Dimensions(
            width: getWidth(),
            height: getHeight(),
            aspectRatio: getAspectRatio()),
        gravity: _gravity,
        x: _x,
        y: _y);
  }
}