import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/transformation/common.dart';

import 'effect.dart';

class Sepia extends Effect {

  dynamic level;

  Sepia([this.level]);

  @override
  String toString() {
    return super.toString().joinWithValues(['sepia'], separator: paramKeyValueSeparator).joinWithValues([level]);
  }
}

class Accelerate extends Effect {
  dynamic _rate;

  Accelerate([this._rate]);

  Accelerate rate(dynamic rate) {
    _rate = rate;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['accelerate'], separator: paramKeyValueSeparator).joinWithValues([_rate]);
  }
}

class Deshake extends Effect {

  ShakeStrength? factor;

  Deshake([this.factor]);

  Deshake shakeStrength(ShakeStrength shakeStrength) {
    factor = shakeStrength;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['deshake'], separator: paramKeyValueSeparator).joinWithValues([factor]);
  }
}

class Reverse extends Effect {
  @override
  String toString() {
    return super.toString().joinWithValues(['reverse'], separator: paramKeyValueSeparator);
  }
}

class Boomerang extends Effect {
  @override
  String toString() {
    return super.toString().joinWithValues(['boomerang'], separator: paramKeyValueSeparator);
  }
}

class MakeTransparent extends Effect {
  dynamic _tolerance;
  dynamic _colorToReplace;

  MakeTransparent({dynamic tolerance, dynamic colorToReplace}) {
    _tolerance = tolerance;
    _colorToReplace = colorToReplace;
  }

  MakeTransparent tolerance(dynamic tolerance) {
    _tolerance = tolerance;
    return this;
  }

  MakeTransparent colorToReplace(dynamic colorToReplace) {
    _colorToReplace = colorToReplace;
    return this;
  }
  
  @override
  String toString() {
    return super.toString().joinWithValues(['make_transparent'], separator: paramKeyValueSeparator).joinWithValues([_tolerance]).joinWithValues([(_colorToReplace != null ? 'co_'.joinWithValues([_colorToReplace]) : null)]);
  }
}

class Noise extends Effect {
  dynamic level;

  Noise([this.level]);

  @override
  String toString() {
    return super.toString().joinWithValues(['noise'], separator: paramKeyValueSeparator).joinWithValues([level]);
  }
}

class ShakeStrength {

  int factor;

  ShakeStrength(this.factor);

  static ShakeStrength pixels16() => ShakeStrength(16);
  static ShakeStrength pixels32() => ShakeStrength(32);
  static ShakeStrength pixels48() => ShakeStrength(48);
  static ShakeStrength pixels64() => ShakeStrength(64);

  @override
  String toString() {
    return factor.toString();
  }
}