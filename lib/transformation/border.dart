import 'package:cloudinary_dart/src/extensions/string_extension.dart';

import 'common.dart';

class Border extends Action {
  dynamic _width;
  dynamic _color;
  dynamic _roundCorners;
  String type = 'solid';

  Border({dynamic width, dynamic color, dynamic roundCorners}) {
    _width = width;
    _color = color;
    _roundCorners = roundCorners;
  }

  static Border solid([dynamic width, dynamic color]) {
    return Border(width: width, color: color);
  }

  //TODO: Round corners

  @override
  String toString() {
    return 'bo_${_width}px_${type}_$_color'.joinWithValues(_roundCorners, separator: paramSeparator);
  }
}