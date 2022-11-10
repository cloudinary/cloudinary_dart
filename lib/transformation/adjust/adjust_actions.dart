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