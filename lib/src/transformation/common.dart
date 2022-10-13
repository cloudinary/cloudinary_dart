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

abstract class BaseBuilder<B> extends TransformationComponentBuilder {
  dynamic _width;
  dynamic _height;
  dynamic _aspectRatio;
  bool? _relative;
  bool? _regionRelative;

  Object getThis() {
    return B;
  }

  B width(dynamic width) {
    _width = width;
    return getThis() as B;
  }

  B height(dynamic height) {
    _height = height;
    return getThis() as B;
  }

  B aspectRatio(dynamic aspectRatio) {
    _aspectRatio = aspectRatio;
    return getThis() as B;
  }

  B relative(bool? relative) {
    _relative = relative;
    return getThis() as B;
  }

  B regionRelative(bool? regionRelative) {
    _regionRelative = regionRelative;
    return getThis() as B;
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
