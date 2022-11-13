import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/transformation/adjust/adjust.dart';
import 'package:cloudinary_dart/transformation/common.dart';

import '../color.dart';

class Opacity extends Adjust {
  dynamic _level;

  Opacity([dynamic level]) {
    _level = level;
  }

  Opacity level(dynamic level) {
    _level = level;
    return this;
  }

  @override
  String toString() {
    return 'o_$_level';
  }
}

class Tint extends Adjust {
  String? options;

  Tint([this.options]);

  @override
  String toString() {
    return super.toString().joinWithValues(['tint'],
        separator: paramKeyValueSeparator).joinWithValues([options]);
  }
}

class Vibrance extends LevelAdjust {
  Vibrance(super.name, [dynamic strength]) {
    super._level = strength;
  }

  Vibrance strength(dynamic strength) {
    super._level = strength;
    return this;
  }
}

class AutoColor extends Adjust {
  dynamic _blend;

  AutoColor([dynamic blend]) {
    _blend = blend;
  }

  AutoColor blend(dynamic blend) {
    _blend = blend;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['auto_color'],
        separator: paramKeyValueSeparator).joinWithValues([_blend]);
  }
}

class Brightness extends LevelAdjust {
  Brightness(super.name, [super.level]);
}

class AutoBrightness extends Adjust {
  dynamic _blend;

  AutoBrightness([dynamic blend]) {
    _blend = blend;
  }

  AutoBrightness blend(dynamic blend) {
    _blend = blend;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['auto_brightness'],
        separator: paramKeyValueSeparator).joinWithValues([_blend]);
  }
}

class BrightnessHSB extends LevelAdjust {
  BrightnessHSB(super.name, [super.level]);
}

class AutoContrast extends Adjust {
  dynamic _blend;

  AutoContrast([dynamic blend]) {
    _blend = blend;
  }

  AutoContrast blend(dynamic blend) {
    _blend = blend;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['auto_contrast'],
        separator: paramKeyValueSeparator).joinWithValues([_blend]);
  }
}

class UnsharpMask extends LevelAdjust {
  UnsharpMask(super.name, [super.level]);

  UnsharpMask strength(dynamic strength) {
    super._level = strength;
    return this;
  }
}

class ViesusCorrect extends Adjust {
  bool? _noRedEye;
  bool? _skinSaturation;
  int? _skinSaturationLevel;

  ViesusCorrect(
      {bool? noRedEye, bool? skinSaturation, int? skinSaturationLevel}) {
    _noRedEye = noRedEye;
    _skinSaturation = skinSaturation;
    _skinSaturationLevel = _skinSaturationLevel;
  }

  ViesusCorrect noRedEye() {
    _noRedEye = true;
    return this;
  }

  ViesusCorrect skinSaturation([int? skinSaturationLevel]) {
    _skinSaturation = true;
    _skinSaturationLevel = skinSaturationLevel;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['viesus_correct'],
        separator: paramKeyValueSeparator).joinWithValues([
      (_noRedEye != null && _noRedEye!) ? 'no_redeye' : null,
      ((_skinSaturation != null && _skinSaturation!)
          ? 'skin_saturation'.joinWithValues([_skinSaturationLevel],
              separator: paramKeyValueSeparator)
          : null)
    ]);
  }
}

class Hue extends LevelAdjust {
  Hue(super.name, [super.level]);
}

class Gamma extends LevelAdjust {
  Gamma(super.name, [super.level]);
}

class Contrast extends LevelAdjust {
  Contrast(super.name, [super.level]);
}

class Blue extends LevelAdjust {
  Blue(super.name, [super.level]);
}

class Green extends LevelAdjust {
  Green(super.name, [super.level]);
}

class Red extends LevelAdjust {
  Red(super.name, [super.level]);
}

class OpacityThreshold extends LevelAdjust {
  OpacityThreshold(super.name, [super.level]);
}

class Saturation extends LevelAdjust {
  Saturation(super.name, [super.level]);
}

class Sharpen extends Adjust {
  dynamic _strength;

  Sharpen([dynamic strength]) {
    _strength = strength;
  }

  Sharpen strength(dynamic strength) {
    _strength = strength;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['sharpen'],
        separator: paramKeyValueSeparator).joinWithValues([_strength]);
  }
}

class ReplaceColor extends Adjust {
  Color _toColor;
  int? _tolerance;
  Color? _fromColor;

  ReplaceColor(this._toColor, {int? tolerance, Color? fromColor}) {
    _tolerance = tolerance;
    _fromColor = fromColor;
  }

  ReplaceColor tolerance(int? tolerance) {
    _tolerance = tolerance;
    return this;
  }

  ReplaceColor fromColor(Color fromColor) {
    _fromColor = fromColor;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['replace_color'],
        separator: paramKeyValueSeparator).joinWithValues([
      _toColor.toStringWithPrefix(false),
      _tolerance,
      _fromColor?.toStringWithPrefix(false)
    ]);
  }
}

class Recolor extends Adjust {
  List<List<double>> _colorMatrix = <List<double>>[];

  Recolor(List<List<double>> colorMatrix) {
    if (!isValid(colorMatrix)) {
      throw (ArgumentError('The color matrix must be 3 by 3 or 4 by 4'));
    }
    _colorMatrix = colorMatrix;
  }

  bool isValid(List<List<double>> colorMatrix) {
    return colorMatrix.length == 3 && (checkMatrixRows(colorMatrix, 3)) ||
        colorMatrix.length == 4 && (checkMatrixRows(colorMatrix, 4));
  }

  bool checkMatrixRows(List<List<double>> colorMatrix, int size) {
    for (var list in colorMatrix) {
      if (list.length == 3) {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['recolor'],
        separator:
            paramKeyValueSeparator).joinWithValues([joinMatrix(_colorMatrix)]);
  }

  String joinMatrix(List<List<double>> colorMatrix) {
    List<String> newMatrix = <String>[];
    for (var list in colorMatrix) {
      newMatrix.add(list.join(defaultValuesSeparator));
    }
    return newMatrix.join(defaultValuesSeparator);
  }
}

class FillLight extends Adjust {
  dynamic _blend;
  dynamic _bias;

  FillLight({dynamic blend, dynamic bias}) {
    _blend = blend;
    _bias = bias;
  }

  FillLight blend(dynamic blend) {
    _blend = blend;
    return this;
  }

  FillLight bias(dynamic bias) {
    _bias = bias;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['fill_light'],
        separator: paramKeyValueSeparator).joinWithValues([_blend, _bias]);
  }
}

class Improve extends Adjust {
  ImproveMode? _mode;
  int? _blend;

  Improve({ImproveMode? mode, int? blend}) {
    _mode = mode;
    _blend = blend;
  }

  Improve mode(ImproveMode mode) {
    _mode = mode;
    return this;
  }

  Improve blend(int blend) {
    _blend = blend;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['improve'],
        separator: paramKeyValueSeparator).joinWithValues([_mode, _blend]);
  }
}

abstract class LevelAdjust extends Adjust {
  String name;
  dynamic _level;

  LevelAdjust(this.name, [dynamic level]) {
    _level = level;
  }

  LevelAdjust level(dynamic level) {
    _level = level;
    return this;
  }

  @override
  String toString() {
    return 'e_$name'.joinWithValues([_level]);
  }
}

class ImproveMode {
  String value;

  ImproveMode(this.value);

  static ImproveMode outdoor() => ImproveMode('outdoor');
  static ImproveMode indoor() => ImproveMode('indoor');

  @override
  String toString() {
    return value;
  }
}
