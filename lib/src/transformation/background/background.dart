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

  static Background blurred([BlurredBackgroundBuilder? options]) {
    var builder = BlurredBackgroundBuilder();
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  static Background border([BorderBackgroundBuilder? options]) {
    var builder = BorderBackgroundBuilder();
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  static Background borderGradient([BorderGradientBackgroundBuilder? options]) {
    var builder = BorderGradientBackgroundBuilder();
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  static Background predominant([PredominantBackgroundBuilder? options]) {
    var builder = PredominantBackgroundBuilder();
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  static Background predominantGradient([PredominantGradientBackgroundBuilder? options]) {
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
