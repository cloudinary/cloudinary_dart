import '../src/extensions/string_extension.dart';
import 'common.dart';

class Region {
  static Region faces(Faces faces) {
    return faces;
  }
}

class Faces extends Region {
  @override
  String toString() {
    return 'faces';
  }
}

class OCR extends Region {
  @override
  String toString() {
    return 'g_ocr_text';
  }
}

class Custom extends Region {
  dynamic _x;
  dynamic _y;
  dynamic _width;
  dynamic _height;

  Custom x(dynamic x) {
    _x = x;
    return this;
  }

  Custom y(dynamic y) {
    _y = y;
    return this;
  }

  Custom width(dynamic width) {
    _width = width;
    return this;
  }

  Custom height(dynamic height) {
    _height = height;
    return this;
  }

  @override
  String toString() {
    return ''.joinWithValues([
      ((_height != null) ? 'h_$_height' : null),
      ((_width != null) ? 'w_$_width' : null),
      ((_x != null) ? 'x_$_x' : null),
      ((_y != null) ? 'y_$_y' : null)
    ], separator: paramSeparator, actionSeparator: '');
  }
}
