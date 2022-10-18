import 'package:cloudinary_dart/src/transformation/transformation.dart';

const defaultValuesSeparator = ":";
const defaultComponentSeparator = "/";
const paramSeparator = ",";
const paramKeyValueSeparator = "_";

class Param {
  String key;
  dynamic value;

  Param(this.key, this.value);
}

abstract class Action {
  @override
  String toString() {
    return super.toString();
  }
}

abstract class BaseBuilder<R> extends TransformationComponentBuilder {
  dynamic _width;
  dynamic _height;
  dynamic _aspectRatio;
  bool? _relative;
  bool? _regionRelative;

  Object getThis() {
    return R;
  }

  R width(dynamic width) {
    _width = width;
    return getThis() as R;
  }

  R height(dynamic height) {
    _height = height;
    return getThis() as R;
  }

  R aspectRatio(dynamic aspectRatio) {
    _aspectRatio = aspectRatio;
    return getThis() as R;
  }

  R relative(bool? relative) {
    _relative = relative;
    return getThis() as R;
  }

  R regionRelative(bool? regionRelative) {
    _regionRelative = regionRelative;
    return getThis() as R;
  }

  dynamic getWidth() {
    return _width;
  }

  dynamic getHeight() {
    return _height;
  }

  dynamic getAspectRatio() {
    return _aspectRatio;
  }

  bool? getRelative() {
    return _relative;
  }

  bool? getRegionRelative() {
    return _regionRelative;
  }
}
