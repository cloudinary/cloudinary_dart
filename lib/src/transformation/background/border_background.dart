import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/transformation/background/background.dart';

import '../color.dart';

class BorderBackgroundObject extends Background {
  bool? contrast;
  List<Color>? palette;

  BorderBackgroundObject({this.contrast, this.palette}) {
    if (palette != null && palette!.isEmpty) {
      throw ArgumentError(
          'If using a palette it must contain at least one color');
    }
  }

  @override
  String getValues() {
    return 'auto:border'.joinWithValues([
      (contrast == true) ? 'contrast' : null
    ], separator: "_").joinWithValues(
        [(palette != null) ? 'palette_${palette!.join('_')}' : null]);
  }
}

class BorderBackground
    implements BackgroundBuilder<BorderBackgroundObject, BorderBackground> {
  bool? _contrast;
  List<Color>? _palette;

  BorderBackground contrast() {
    _contrast = true;
    return this;
  }

  BorderBackground palette(List<Color> colors) {
    _palette = colors;
    return this;
  }

  @override
  BorderBackgroundObject build() {
    return BorderBackgroundObject(contrast: _contrast, palette: _palette);
  }

  @override
  copyWith(other) {
    _contrast = other._contrast;
    _palette = other._palette;
  }
}
