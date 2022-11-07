import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/transformation/common.dart';

import 'effect.dart';

class Sepia extends Effect {
  dynamic level;

  Sepia([this.level]);

  @override
  String toString() {
    return super.toString().joinWithValues(['sepia'],
        separator: paramKeyValueSeparator).joinWithValues([level]);
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
    return super.toString().joinWithValues(['accelerate'],
        separator: paramKeyValueSeparator).joinWithValues([_rate]);
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
    return super.toString().joinWithValues(['deshake'],
        separator: paramKeyValueSeparator).joinWithValues([factor]);
  }
}

class Reverse extends Effect {
  @override
  String toString() {
    return super
        .toString()
        .joinWithValues(['reverse'], separator: paramKeyValueSeparator);
  }
}

class Boomerang extends Effect {
  @override
  String toString() {
    return super
        .toString()
        .joinWithValues(['boomerang'], separator: paramKeyValueSeparator);
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
    return super.toString().joinWithValues(['make_transparent'],
        separator:
            paramKeyValueSeparator).joinWithValues(
        [_tolerance]).joinWithValues([
      (_colorToReplace != null ? 'co_'.joinWithValues([_colorToReplace]) : null)
    ]);
  }
}

class FadeIn extends Effect {
  int? _duration;

  FadeIn([int? duration]) {
    _duration = duration;
  }

  FadeIn duration(int duration) {
    _duration = duration;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['fade'],
        separator: paramKeyValueSeparator).joinWithValues([_duration]);
  }
}

class FadeOut extends Effect {
  int? _duration;

  FadeOut([int? duration]) {
    _duration = duration;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['fade'],
        separator: paramKeyValueSeparator).joinWithValues(['-$_duration']);
  }
}

class Loop extends Effect {
  int? _additionalIterations;

  Loop([int? additionalIterations]) {
    _additionalIterations = additionalIterations;
  }

  Loop additionalIterations(int additionalIterations) {
    _additionalIterations = additionalIterations;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['loop'],
        separator:
            paramKeyValueSeparator).joinWithValues([_additionalIterations]);
  }
}

class Blackwhite extends Effect {
  dynamic _threshold;

  Blackwhite([dynamic threshold]) {
    _threshold = threshold;
  }

  Blackwhite threshold(dynamic threshold) {
    _threshold = threshold;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['blackwhite'],
        separator: paramKeyValueSeparator).joinWithValues([_threshold]);
  }
}

class Dither extends Effect {
  DitherObject? filter;

  Dither([this.filter]);

  Dither type(DitherObject filter) {
    this.filter = filter;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['ordered_dither'],
        separator: paramKeyValueSeparator).joinWithValues([filter]);
  }
}

class Vignette extends Effect {
  dynamic _strength;

  Vignette([dynamic strength]) {
    _strength = strength;
  }

  Vignette strength(dynamic strength) {
    _strength = strength;
    return this;
  }
  
  @override
  String toString() {
    return super.toString().joinWithValues(['vignette'], separator: paramKeyValueSeparator).joinWithValues([_strength]);
  }
}

class SimulateColorBlind extends Effect {
  SimulateColorBlindObject? _condition;

  SimulateColorBlind([SimulateColorBlindObject? condition]) {
    _condition = condition;
  }

  SimulateColorBlind condition(SimulateColorBlindObject condition) {
    _condition = condition;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['simulate_colorblind'], separator: paramKeyValueSeparator).joinWithValues([_condition]);
  }
}

class Cartoonify extends Effect {
  dynamic _lineStrength;
  dynamic _colorReductionLevel;
  late bool _blackwhite;

  Cartoonify({dynamic lineStrength, dynamic colorReductionLevel, bool? blackwhite}) {
    _lineStrength = lineStrength;
    _colorReductionLevel = colorReductionLevel;
    _blackwhite = blackwhite ?? false;
  }

  Cartoonify lineStrength(dynamic lineStrength) {
    _lineStrength = lineStrength;
    return this;
  }

  Cartoonify colorReductionLevel(dynamic colorReductionLevel) {
    _colorReductionLevel = colorReductionLevel;
    return this;
  }

  Cartoonify blackwhite([bool blackwhite = true]) {
    _blackwhite = blackwhite;
    return this;
  }
  
  @override
  String toString() {
    return super.toString().joinWithValues(['cartoonify'], separator: paramKeyValueSeparator).joinWithValues([_lineStrength, ((_blackwhite) ? 'bw' : _colorReductionLevel)]);
  }
}

class Noise extends Effect {
  dynamic level;

  Noise([this.level]);

  @override
  String toString() {
    return super.toString().joinWithValues(['noise'],
        separator: paramKeyValueSeparator).joinWithValues([level]);
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

class DitherObject {
  int value;

  DitherObject(this.value);

  static DitherObject threshold1x1NonDither() => DitherObject(0);
  static DitherObject checkerboard2x1Dither() => DitherObject(1);
  static DitherObject ordered2x2Dispersed() => DitherObject(2);
  static DitherObject ordered3x3Dispersed() => DitherObject(3);
  static DitherObject ordered4x4Dispersed() => DitherObject(4);
  static DitherObject ordered8x8Dispersed() => DitherObject(5);
  static DitherObject halftone4x4Angled() => DitherObject(6);
  static DitherObject halftone6x6Angled() => DitherObject(7);
  static DitherObject halftone8x8Angled() => DitherObject(8);
  static DitherObject halftone4x4Orthogonal() => DitherObject(9);
  static DitherObject halftone6x6Orthogonal() => DitherObject(10);
  static DitherObject halftone8x8Orthogonal() => DitherObject(11);
  static DitherObject halftone16x16Orthogonal() => DitherObject(12);
  static DitherObject circles5x5Black() => DitherObject(13);
  static DitherObject circles5x5White() => DitherObject(14);
  static DitherObject circles6x6Black() => DitherObject(15);
  static DitherObject circles6x6White() => DitherObject(16);
  static DitherObject circles7x7Black() => DitherObject(17);
  static DitherObject circles7x7White() => DitherObject(18);

  @override
  String toString() {
    return value.toString();
  }
}

class SimulateColorBlindObject {
  String value;

  SimulateColorBlindObject(this.value);
  static deuteranopia() => SimulateColorBlindObject("deuteranopia");
  static protanopia() => SimulateColorBlindObject("protanopia");
  static tritanopia() => SimulateColorBlindObject("tritanopia");
  static tritanomaly() => SimulateColorBlindObject("tritanomaly");
  static deuteranomaly() => SimulateColorBlindObject("deuteranomaly");
  static cone_monochromacy() => SimulateColorBlindObject("cone_monochromacy");
  static rod_monochromacy() => SimulateColorBlindObject("rod_monochromacy");

  @override
  String toString() {
    return value;
  }
}
