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
  dynamic width;
  dynamic height;
  dynamic aspectRatio;
  bool? relative;
  bool? regionRelative;

  Object getThis() {
    return B;
  }

  B setWidth(dynamic width) {
    this.width = width;
    return getThis() as B;
  }

  B setHeight(dynamic height) {
    this.height = height;
    return getThis() as B;
  }

  B setAspectRatio(dynamic aspectRatio) {
    this.aspectRatio = aspectRatio;
    return getThis() as B;
  }

  B setRelative(bool relative) {
    this.relative = relative;
    return getThis() as B;
  }

  B setRegionRelative(dynamic regionRelative) {
    this.regionRelative = regionRelative;
    return getThis() as B;
  }
}