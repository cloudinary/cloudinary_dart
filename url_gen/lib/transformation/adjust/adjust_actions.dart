import '../../src/extensions/string_extension.dart';
import '../color.dart';
import '../common.dart';
import 'adjust.dart';

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
        actionSeparator: paramKeyValueSeparator).joinWithValues([options]);
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([_blend]);
  }
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([_blend]);
  }
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([_blend]);
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([
      (_noRedEye != null && _noRedEye!) ? 'no_redeye' : null,
      ((_skinSaturation != null && _skinSaturation!)
          ? 'skin_saturation'.joinWithValues([_skinSaturationLevel],
              separator: paramKeyValueSeparator,
              actionSeparator: paramKeyValueSeparator)
          : null)
    ]);
  }
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([_strength]);
  }
}

class ReplaceColor extends Adjust {
  final Color _toColor;
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([
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
        actionSeparator:
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
        actionSeparator:
            paramKeyValueSeparator).joinWithValues([_blend, _bias]);
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
        actionSeparator:
            paramKeyValueSeparator).joinWithValues([_mode, _blend]);
  }
}

class LevelAdjust extends Adjust {
  String name;
  dynamic _level;

  LevelAdjust(this.name, [dynamic level]) {
    _level = level;
  }

  LevelAdjust level(dynamic level) {
    _level = level;
    return this;
  }

  LevelAdjust strength(dynamic strength) {
    _level = strength;
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
