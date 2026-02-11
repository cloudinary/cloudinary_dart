import '../color.dart';
import 'border_background.dart';
import 'border_gradient_background.dart';
import 'color_background.dart';
import 'blurred_background.dart';
import 'predominant_background.dart';

abstract class Background {
  String getValues();

  @override
  String toString() {
    return getValues();
  }

  static Background auto() => AutoBackground();

  static Background blurred([BlurredBackground? blurredBackground]) {
    if (blurredBackground != null) {
      return blurredBackground;
    }
    return BlurredBackground();
  }

  static Background border([BorderBackground? borderBackground]) {
    if (borderBackground != null) {
      return borderBackground;
    }
    return BorderBackground();
  }

  static Background borderGradient(
      [BorderGradientBackground? borderGradientBackground]) {
    if (borderGradientBackground != null) {
      return borderGradientBackground;
    }
    return BorderGradientBackground();
  }

  static Background predominant(
      [PredominantBackground? predominantBackground]) {
    if (predominantBackground != null) {
      return predominantBackground;
    }
    return PredominantBackground();
  }

  static Background predominantGradient(
      [PredominantGradientBackground? predominantGradientBackground]) {
    if (predominantGradientBackground != null) {
      return predominantGradientBackground;
    }
    return PredominantGradientBackground();
  }

  static Background color(Color color) {
    return ColorBackground(color);
  }

  static Background colorString(String value) {
    return color(Color.parseString(value));
  }
}

class AutoBackground extends Background {
  @override
  String getValues() {
    return 'auto';
  }
}
