import 'package:cloudinary_dart/src/transformation/background/blurred_background.dart';
import 'package:cloudinary_dart/src/transformation/background/predominant_background.dart';

import '../color.dart';
import 'border_background.dart';
import 'border_gradient_background.dart';
import 'color_background.dart';

abstract class Background {
  String getValues();

  @override
  String toString() {
    return getValues();
  }

  static Background auto() => AutoBackground();

  static Background blurred([BlurredBackground? options]) {
    var builder = BlurredBackground();
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  static Background border([BorderBackground? options]) {
    var builder = BorderBackground();
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  static Background borderGradient([BorderGradientBackground? options]) {
    var builder = BorderGradientBackground();
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  static Background predominant([PredominantBackground? options]) {
    var builder = PredominantBackground();
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  static Background predominantGradient(
      [PredominantGradientBackgroundBuilder? options]) {
    var builder = PredominantGradientBackgroundBuilder();
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
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

abstract class BackgroundBuilder<T, B> {
  T build();
  copyWith(B);
}
