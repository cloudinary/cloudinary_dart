import '../color.dart';
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

  static ViesusCorrect viesusCorrect(
      {bool? noRedEye, bool? skinSaturation, int? skinSaturationLevel}) {
    return ViesusCorrect(
        noRedEye: noRedEye,
        skinSaturation: skinSaturation,
        skinSaturationLevel: skinSaturationLevel);
  }

  static Hue hue([dynamic level]) {
    return Hue('hue', level);
  }

  static Gamma gamma([dynamic level]) {
    return Gamma('gamma', level);
  }

  static Contrast contrast([dynamic level]) {
    return Contrast('contrast', level);
  }

  static Green green([dynamic level]) {
    return Green('green', level);
  }

  static Blue blue([dynamic level]) {
    return Blue('blue', level);
  }

  static Red red([dynamic level]) {
    return Red('red', level);
  }

  static OpacityThreshold opacityThreshold([dynamic level]) {
    return OpacityThreshold('opacity_threshold', level);
  }

  static Saturation saturation([dynamic level]) {
    return Saturation('saturation', level);
  }

  static Sharpen sharpen([dynamic strength]) {
    return Sharpen(strength);
  }

  static ReplaceColor replaceColor(Color color,
      {int? tolerance, Color? fromColor}) {
    return ReplaceColor(color, tolerance: tolerance, fromColor: fromColor);
  }

  static Recolor recolor(List<List<double>> colorMatrix) {
    return Recolor(colorMatrix);
  }

  static FillLight fillLight({dynamic blend, dynamic bias}) {
    return FillLight(blend: blend, bias: bias);
  }

  static Improve improve({ImproveMode? mode, int? blend}) {
    return Improve(mode: mode, blend: blend);
  }

  static By3dLut by3dLut(String publicId) {
    return By3dLut(publicId);
  }

  @override
  String toString() {
    return 'e';
  }
}
