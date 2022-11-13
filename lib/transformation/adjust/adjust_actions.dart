import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/transformation/adjust/adjust.dart';
import 'package:cloudinary_dart/transformation/common.dart';

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
    return super.toString().joinWithValues(['tint'], separator: paramKeyValueSeparator).joinWithValues([options]);
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
    return super.toString().joinWithValues(['auto_color'], separator: paramKeyValueSeparator).joinWithValues([_blend]);
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
    return super.toString().joinWithValues(['auto_brightness'], separator: paramKeyValueSeparator).joinWithValues([_blend]);
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
    return super.toString().joinWithValues(['auto_contrast'], separator: paramKeyValueSeparator).joinWithValues([_blend]);
  }
}

class UnsharpMask extends LevelAdjust {

  UnsharpMask(super.name, [super.level]);

  UnsharpMask strength(dynamic strength){
    super._level = strength;
    return this;
  }
}

class ViesusCorrect extends Adjust {
  bool? _noRedEye;
  bool? _skinSaturation;
  int? _skinSaturationLevel;

  ViesusCorrect({bool? noRedEye, bool? skinSaturation, int? skinSaturationLevel}) {
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
    return super.toString().joinWithValues(['viesus_correct'], separator: paramKeyValueSeparator).joinWithValues([(_noRedEye != null && _noRedEye!) ? 'no_redeye' : null,((_skinSaturation != null && _skinSaturation!) ? 'skin_saturation'.joinWithValues([_skinSaturationLevel], separator: paramKeyValueSeparator) : null)]);
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