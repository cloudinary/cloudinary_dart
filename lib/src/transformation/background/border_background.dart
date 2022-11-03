import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/transformation/background/background.dart';
import 'package:cloudinary_dart/src/transformation/common.dart';

import '../color.dart';

class BorderBackground extends AutoBackground {
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
  String getValues() {
    var values = super.getValues();
    return values.joinWithValues(['border'],
        separator: defaultValuesSeparator).joinWithValues([
      (_contrast == true) ? 'contrast' : null
    ], separator: "_").joinWithValues(
        [(_palette != null) ? 'palette_${_palette!.join('_')}' : null]);
  }
}
