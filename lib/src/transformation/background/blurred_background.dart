import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/util/validations.dart';

import 'background.dart';

class BlurredBackground extends Background {
  final int? _intensity;
  final int? _brightness;

  BlurredBackground([this._intensity, this._brightness]);

  @override
  String getValues() {
    return 'blurred'.joinWithValues([_intensity, _brightness]);
  }
}

class BlurredBackgroundBuilder implements BackgroundBuilder<BlurredBackground, BlurredBackgroundBuilder> {
  int? _intensity;
  int? _brightness;

  BlurredBackgroundBuilder({int? intensity, int? brightness}) {
    _intensity = intensity.cldRange(1, 2000);
    _brightness = brightness.cldRange(-300, 100);
  }

  BlurredBackgroundBuilder intensity(int intensity) {
    _intensity = _intensity;
    return this;
  }

  BlurredBackgroundBuilder brightness(int brightness) {
    _brightness = _brightness;
    return this;
  }

  @override
  BlurredBackground build() {
    return BlurredBackground(_intensity, _brightness);
  }

  @override
  void copyWith(other) {
    _intensity = other._intensity;
    _brightness = other._brightness;
  }
}
