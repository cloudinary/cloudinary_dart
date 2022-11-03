import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/util/validations.dart';

import 'background.dart';

class BlurredBackgroundObject extends Background {
  final int? _intensity;
  final int? _brightness;

  BlurredBackgroundObject([this._intensity, this._brightness]);

  @override
  String getValues() {
    return 'blurred'.joinWithValues([_intensity, _brightness]);
  }
}

class BlurredBackground
    implements BackgroundBuilder<BlurredBackgroundObject, BlurredBackground> {
  int? _intensity;
  int? _brightness;

  BlurredBackground({int? intensity, int? brightness}) {
    _intensity = intensity.cldRange(1, 2000);
    _brightness = brightness.cldRange(-300, 100);
  }

  BlurredBackground intensity(int intensity) {
    _intensity = _intensity;
    return this;
  }

  BlurredBackground brightness(int brightness) {
    _brightness = _brightness;
    return this;
  }

  @override
  BlurredBackgroundObject build() {
    return BlurredBackgroundObject(_intensity, _brightness);
  }

  @override
  void copyWith(other) {
    _intensity = other._intensity;
    _brightness = other._brightness;
  }
}
