import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/transformation/background/background.dart';

import '../color.dart';

class BorderGradientBackgroundObject extends Background {
  bool? contrast;
  List<Color>? palette;
  int? gradientColors;
  GradientDirection? gradientDirection;

  BorderGradientBackgroundObject(
      {this.contrast,
      this.palette,
      this.gradientColors,
      this.gradientDirection}) {
    if (palette != null && palette!.isEmpty) {
      throw ArgumentError(
          'If using a palette it must contain at least one color');
    }
  }

  @override
  String getValues() {
    var fullType = 'auto:border_gradient'
        .joinWithValues([(contrast == true) ? 'contrast' : null]);
    return fullType.joinWithValues([
      gradientColors,
      gradientDirection,
      (palette != null) ? 'palette_${palette!.join('_')}' : null
    ]);
  }
}

class BorderGradientBackground
    implements
        BackgroundBuilder<BorderGradientBackgroundObject,
            BorderGradientBackground> {
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
  BorderGradientBackgroundObject build() {
    return BorderGradientBackgroundObject(
        contrast: _contrast,
        palette: _palette,
        gradientColors: _gradientColors,
        gradientDirection: _gradientDirection);
  }

  @override
  copyWith(other) {
    _contrast = other._contrast;
    _palette = other._palette;
    _gradientDirection = other._gradientDirection;
    _gradientColors = other._gradientColors;
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

  static GradientDirection diagonal_desc() {
    return GradientDirection('diagonal_desc');
  }

  static GradientDirection diagonal_asc() {
    return GradientDirection('diagonal_asc');
  }

  @override
  String toString() {
    return value;
  }
}
