import 'package:cloudinary_url_g../extensions/string_extension.dart';
import 'package:cloudinary_url_g../transformation/layer/common.dart';
import 'package:cloudinary_url_g../transformation/layer/position/position.dart';
import 'package:cloudinary_url_g../transformation/reshape/reshape.dart';

import '../common.dart';
import '../source/source.dart';

class Shear extends Reshape {
  dynamic _skewX;
  dynamic _skewY;

  Shear({dynamic skewX, dynamic skewY}) {
    _skewX = skewX;
    _skewY = skewY;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['shear'],
        actionSeparator:
            paramKeyValueSeparator).joinWithValues([_skewX, _skewY]);
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
    return super.toString().joinWithValues(['distort'],
        actionSeparator:
            paramKeyValueSeparator).joinWithValues(
        [points.join(defaultValuesSeparator)]);
  }
}

class DistortArc extends Reshape {
  dynamic degrees;

  DistortArc(this.degrees);

  @override
  String toString() {
    return super.toString().joinWithValues(['distort'],
        actionSeparator:
            paramKeyValueSeparator).joinWithValues(['arc', degrees]);
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
    return super.toString().joinWithValues(['trim'],
        actionSeparator:
            paramKeyValueSeparator).joinWithValues(
        [_colorSimilarity, _colorOverride]);
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

class CutByImage extends Reshape {
  Source source;
  Position? _position;

  CutByImage(this.source);

  CutByImage position(Position position) {
    _position = position;
    return this;
  }

  @override
  String toString() {
    return buildLayerComponent('l', source,
        position: _position, extras: [Param('fl', 'cutter')]);
  }
}
