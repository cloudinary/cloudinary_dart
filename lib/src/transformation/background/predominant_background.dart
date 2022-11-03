import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/transformation/background/background.dart';

import '../color.dart';
import 'border_gradient_background.dart';

class PredominantBackgroundObject extends Background {
  bool? contrast;
  List<Color>? palette;

  PredominantBackgroundObject({this.contrast, this.palette}) {
    if (palette != null && palette!.isEmpty) {
      throw ArgumentError(
          'If using a palette it must contain at least one color');
    }
  }

  @override
  String getValues() {
    return 'auto:predominant'.joinWithValues([
      (contrast != null && contrast == true) ? 'contrast' : null
    ], separator: '_').joinWithValues(
        [(palette != null) ? 'palette_${palette!.join('_')}' : null]);
  }
}

class PredominantBackground
    implements
        BackgroundBuilder<PredominantBackgroundObject, PredominantBackground> {
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
  PredominantBackgroundObject build() {
    return PredominantBackgroundObject(contrast: _contrast, palette: _palette);
  }

  @override
  copyWith(other) {
    _contrast = other._contrast;
    _palette = other._palette;
  }
}

class PredominantGradientBackground extends Background {
  bool? contrast;
  List<Color>? palette;
  int? gradientColors;
  GradientDirection? gradientDirection;

  PredominantGradientBackground(
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
    var fullType = 'auto:predominant_gradient'
        .joinWithValues([(contrast == true) ? 'contrast' : null]);
    return fullType.joinWithValues([
      gradientColors,
      gradientDirection,
      (palette != null) ? 'palette_${palette!.join('_')}' : null
    ]);
  }
}

class PredominantGradientBackgroundBuilder
    implements
        BackgroundBuilder<PredominantGradientBackground,
            PredominantGradientBackgroundBuilder> {
  bool? _contrast;
  List<Color>? _palette;
  int? _gradientColors;
  GradientDirection? _gradientDirection;

  PredominantGradientBackgroundBuilder gradientColors(int gradientColors) {
    _gradientColors = gradientColors;
    return this;
  }

  PredominantGradientBackgroundBuilder gradientDirection(
      GradientDirection gradientDirection) {
    _gradientDirection = gradientDirection;
    return this;
  }

  PredominantGradientBackgroundBuilder contrast() {
    _contrast = _contrast;
    return this;
  }

  PredominantGradientBackgroundBuilder palette(List<Color> colors) {
    _palette = colors;
    return this;
  }

  @override
  PredominantGradientBackground build() {
    return PredominantGradientBackground(
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
