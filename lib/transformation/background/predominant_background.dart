import 'package:cloudinary_dart/src/extensions/string_extension.dart';

import '../color.dart';
import 'border_gradient_background.dart';
import 'background.dart';

class PredominantBackground extends Background {
  bool? _contrast;
  List<Color>? _palette;

  PredominantBackground contrast() {
    _contrast = true;
    return this;
  }

  PredominantBackground palette(List<Color> colors) {
    _palette = colors;
    return this;
  }

  @override
  String getValues() {
    return 'auto:predominant'.joinWithValues([
      (_contrast != null && _contrast == true) ? 'contrast' : null
    ], separator: '_').joinWithValues(
        [(_palette != null) ? 'palette_${_palette!.join('_')}' : null]);
  }
}

class PredominantGradientBackground extends Background {
  bool? _contrast;
  List<Color>? _palette;
  int? _gradientColors;
  GradientDirection? _gradientDirection;

  PredominantGradientBackground gradientColors(int gradientColors) {
    _gradientColors = gradientColors;
    return this;
  }

  PredominantGradientBackground gradientDirection(
      GradientDirection gradientDirection) {
    _gradientDirection = gradientDirection;
    return this;
  }

  PredominantGradientBackground contrast() {
    _contrast = _contrast;
    return this;
  }

  PredominantGradientBackground palette(List<Color> colors) {
    _palette = colors;
    return this;
  }

  @override
  String getValues() {
    var fullType = 'auto:predominant_gradient'
        .joinWithValues([(_contrast == true) ? 'contrast' : null]);
    return fullType.joinWithValues([
      _gradientColors,
      _gradientDirection,
      (_palette != null) ? 'palette_${_palette!.join('_')}' : null
    ]);
  }
}
