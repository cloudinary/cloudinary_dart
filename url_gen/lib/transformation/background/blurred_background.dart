import '../../src/extensions/string_extension.dart';
import '../../src/util/validations.dart';
import 'background.dart';

class BlurredBackground extends Background {
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
  String getValues() {
    return 'blurred'.joinWithValues([_intensity, _brightness]);
  }
}
