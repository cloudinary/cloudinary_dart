import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/transformation/round_corners.dart';

import 'common.dart';

class Border extends Action {
  dynamic _width;
  dynamic _color;
  RoundCorners? _roundCorners;
  String type = 'solid';

  Border({dynamic width, dynamic color, RoundCorners? roundCorners}) {
    _width = width;
    _color = color;
    _roundCorners = roundCorners;
  }

  static Border solid([dynamic width, dynamic color]) {
    return Border(width: width, color: color);
  }

  Border roundCorners(RoundCorners roundCorners) {
    _roundCorners = roundCorners;
    return this;
  }

  @override
  String toString() {
    return 'bo_${_width}px_${type}_$_color'.joinWithValues(
        [(_roundCorners != null) ? _roundCorners! : null],
        separator: paramSeparator);
  }
}
