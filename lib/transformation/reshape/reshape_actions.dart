
import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/transformation/reshape/reshape.dart';

import '../common.dart';

class Shear extends Reshape {
  dynamic _skewX;
  dynamic _skewY;

  Shear({dynamic skewX, dynamic skewY}) {
    _skewX = skewX;
    _skewY = skewY;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['shear'], separator: paramKeyValueSeparator).joinWithValues([_skewX, _skewY]);
  }

  Shear skewX(dynamic skewX) {
    _skewX = skewX;
    return this;
  }

  Shear skewY(dynamic skewY) {
    _skewY = skewY;
    return this;
  }
}

class Distort extends Reshape {
  List<dynamic> points = [];

  Distort(this.points);

  @override
  String toString() {
    return super.toString().joinWithValues(['distort'], separator: paramKeyValueSeparator).joinWithValues([points.join(defaultValuesSeparator)]);
  }
}

class DistortArc extends Reshape {
  dynamic degrees;

  DistortArc(this.degrees);

  @override
  String toString() {
    return super.toString().joinWithValues(['distort'], separator: paramKeyValueSeparator).joinWithValues(['arc', degrees]);
  }
}

class Trim extends Reshape {
  dynamic _colorSimilarity;
  dynamic _colorOverride;

  Trim([dynamic colorSimilarity, dynamic colorOverride]) {
    _colorSimilarity = colorSimilarity;
    _colorOverride = colorOverride;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['trim'], separator: paramKeyValueSeparator).joinWithValues([_colorSimilarity, _colorOverride]);
  }

  Trim colorSimilarity(dynamic colorSimilarity) {
    _colorSimilarity = colorSimilarity;
    return this;
  }

  Trim colorOverride(dynamic colorOverride) {
    _colorOverride = colorOverride;
    return this;
  }
}