import 'package:cloudinary_dart/src/transformation/gravity/gravity.dart';
import 'package:cloudinary_dart/src/transformation/resize/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import '../background/background.dart';
import '../common.dart';

class PadObject extends Resize {
  Gravity? gravity;
  dynamic offsetX;
  dynamic offsetY;
  Background? background;

  @override
  String actionType = 'pad';

  PadObject(super.dimensions,
      {super.relative,
      super.regionRelative,
      this.gravity,
      this.offsetX,
      this.offsetY,
      this.background});

  @override
  List<Param?> params() {
    var params = super.params();
    params.add((background != null) ? Param('b', background) : null);
    params.add((gravity != null) ? Param('g', gravity) : null);
    params.add((offsetX != null) ? Param('x', offsetX) : null);
    params.add((offsetY != null) ? Param('y', offsetY) : null);
    return params;
  }
}

class Pad extends BaseBuilder<Pad> {
  dynamic _offsetX;
  dynamic _offsetY;
  CompassGravity? _gravity;
  Background? _background;

  Pad background(Background background) {
    _background = background;
    return this;
  }

  Pad offsetX(dynamic offsetX) {
    _offsetX = offsetX;
    return this;
  }

  Pad offsetY(dynamic offsetX) {
    _offsetX = offsetX;
    return this;
  }

  Pad gravity(CompassGravity gravity) {
    _gravity = gravity;
    return this;
  }

  @override
  PadObject build() {
    return PadObject(
        Dimensions(
            width: getWidth(),
            height: getHeight(),
            aspectRatio: getAspectRatio()),
        relative: getRelative(),
        regionRelative: getRegionRelative(),
        gravity: _gravity,
        offsetX: _offsetX,
        offsetY: _offsetY,
        background: _background);
  }

  @override
  Object getThis() {
    return this;
  }

  @override
  void copyWith(other) {
    width(other.getWidth());
    height(other.getHeight());
    aspectRatio(other.getAspectRatio());
    relative(other.getRelative());
    regionRelative(other.getRegionRelative());
    _gravity = other._gravity;
    _offsetX = other._offsetX;
    _offsetY = other._offsetY;
    _background = other._background;
  }
}
