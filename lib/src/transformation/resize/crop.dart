import 'package:cloudinary_dart/src/transformation/resize/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import '../common.dart';
import '../gravity/gravity.dart';

/// Class CropObject
class CropObject extends Resize {
  Gravity? gravity;
  dynamic zoom;
  dynamic x;
  dynamic y;

  /// Crop constructor
  /// Receives [Dimensions],
  /// [relative],
  /// [relativeRegion],
  /// [gravity],
  /// [zoom],
  /// [x],
  /// [y]
  CropObject(super.dimensions,
      {super.relative,
      super.regionRelative,
      this.gravity,
      this.zoom,
      this.x,
      this.y});

  @override
  List<Param?> params() {
    var params = super.params();
    params.add((gravity != null) ? Param('g', gravity) : null);
    params.add((x != null) ? Param('x', x) : null);
    params.add((y != null) ? Param('y', y) : null);
    params.add((zoom != null) ? Param('z', zoom) : null);
    return params;
  }

  @override
  String actionType = "crop";
}

/// Class Crop
class Crop extends BaseBuilder<Crop> {
  Gravity? _gravity;
  dynamic _zoom;
  dynamic _x;
  dynamic _y;

  Crop gravity(Gravity gravity) {
    _gravity = gravity;
    return this;
  }

  Crop zoom(dynamic zoom) {
    _zoom = zoom;
    return this;
  }

  Crop x(dynamic x) {
    _x = x;
    return this;
  }

  Crop y(dynamic y) {
    _y = y;
    return this;
  }

  @override
  Object getThis() {
    return this;
  }

  @override
  CropObject build() {
    return CropObject(
        Dimensions(
            width: getWidth(),
            height: getHeight(),
            aspectRatio: getAspectRatio()),
        gravity: _gravity,
        zoom: _zoom,
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
    _zoom = other._zoom;
    _x = other._x;
    _y = other._y;
  }
}
