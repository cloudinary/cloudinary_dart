import '../../extensions/string_extension.dart';
import '../color.dart';
import 'background.dart';

class BorderGradientBackground extends Background {
  bool? _contrast;
  List<Color>? _palette;
  int? _gradientColors;
  GradientDirection? _gradientDirection;

  BorderGradientBackground gradientColors(int gradientColors) {
    _gradientColors = gradientColors;
    return this;
  }

  BorderGradientBackground gradientDirection(
      GradientDirection gradientDirection) {
    _gradientDirection = gradientDirection;
    return this;
  }

  BorderGradientBackground contrast() {
    _contrast = _contrast;
    return this;
  }

  BorderGradientBackground palette(List<Color> colors) {
    _palette = colors;
    return this;
  }

  @override
  String getValues() {
    var fullType = 'auto:border_gradient'
        .joinWithValues([(_contrast == true) ? 'contrast' : null]);
    return fullType.joinWithValues([
      _gradientColors,
      _gradientDirection,
      (_palette != null) ? 'palette_${_palette!.join('_')}' : null
    ]);
  }
}

class GradientDirection {
  String value;

  GradientDirection(this.value);

  static GradientDirection horizontal() {
    return GradientDirection('horizontal');
  }

  static GradientDirection vertical() {
    return GradientDirection('vertical');
  }

  static GradientDirection diagonalDesc() {
    return GradientDirection('diagonal_desc');
  }

  static GradientDirection diagonalAsc() {
    return GradientDirection('diagonal_asc');
  }

  @override
  String toString() {
    return value;
  }
}
