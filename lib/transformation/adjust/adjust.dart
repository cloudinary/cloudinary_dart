import '../common.dart';
import 'adjust_actions.dart';

class Adjust extends Action {
  static Opacity opacity([dynamic level]) {
    return Opacity(level);
  }

  static Tint tint([String? options]) {
    return Tint(options);
  }

  static Vibrance vibrance([dynamic strength]) {
    return Vibrance('vibrance', strength);
  }

  static AutoColor autoColor([dynamic blend]) {
    return AutoColor(blend);
  }

  static Brightness brightness([dynamic level]) {
    return Brightness('brightness', level);
  }

  static AutoBrightness autoBrightness([dynamic blend]) {
    return AutoBrightness(blend);
  }

  static BrightnessHSB brightnessHSB([dynamic level]) {
    return BrightnessHSB('brightness_hsb', level);
  }

  static AutoContrast autoContrast([dynamic blend]) {
    return AutoContrast(blend);
  }

  static UnsharpMask unsharpMask([dynamic strength]) {
    return UnsharpMask('unsharp_mask', strength);
  }

  static ViesusCorrect viesusCorrect({bool? noRedEye, bool? skinSaturation, int? skinSaturationLevel}) {
    return ViesusCorrect(noRedEye: noRedEye, skinSaturation: skinSaturation, skinSaturationLevel: skinSaturationLevel);
  }

  @override
  String toString() {
    return 'e';
  }
}