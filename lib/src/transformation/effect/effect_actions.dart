import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/transformation/TransformationUtils.dart';
import 'package:cloudinary_dart/src/transformation/color.dart';
import 'package:cloudinary_dart/src/transformation/common.dart';
import 'package:cloudinary_dart/src/util/validations.dart';

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
    return super.toString().joinWithValues(['vignette'],
        separator: paramKeyValueSeparator).joinWithValues([_strength]);
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
    return super.toString().joinWithValues(['simulate_colorblind'],
        separator: paramKeyValueSeparator).joinWithValues([_condition]);
  }
}

class Cartoonify extends Effect {
  dynamic _lineStrength;
  dynamic _colorReductionLevel;
  late bool _blackwhite;

  Cartoonify(
      {dynamic lineStrength, dynamic colorReductionLevel, bool? blackwhite}) {
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
    return super.toString().joinWithValues(['cartoonify'],
        separator:
            paramKeyValueSeparator).joinWithValues(
        [_lineStrength, ((_blackwhite) ? 'bw' : _colorReductionLevel)]);
  }
}

class Shadow extends Effect {
  dynamic _strength;
  Color? _color;
  dynamic _offsetX;
  dynamic _offsetY;

  Shadow({dynamic strength, Color? color, dynamic offsetX, dynamic offsetY}) {
    _strength = strength;
    _color = color;
    _offsetX = offsetX;
    _offsetY = offsetY;
  }

  Shadow strength(dynamic strength) {
    _strength = strength;
    return this;
  }

  Shadow color(Color color) {
    _color = color;
    return this;
  }

  Shadow offsetX(dynamic offsetX) {
    _offsetX = offsetX;
    return this;
  }

  Shadow offsetY(dynamic offsetY) {
    _offsetY = offsetY;
    return this;
  }

  @override
  String toString() {
    return asComponentString([
      ((_color != null) ? 'co_$_color' : null),
      super.toString().joinWithValues(['shadow'],
          separator:
              paramKeyValueSeparator).joinWithValues(
          [_strength]).joinWithValues([
        ((_offsetX != null) ? 'x_$_offsetX' : null),
        ((_offsetY != null) ? 'y_$_offsetY' : null)
      ], separator: paramSeparator)
    ]);
  }
}

class Vectorize extends Effect {
  dynamic _numOfColors;
  dynamic _detailsLevel;
  dynamic _despeckleLevel;
  dynamic _paths;
  dynamic _cornersLevel;

  Vectorize(
      {dynamic numOfColors,
      dynamic detailsLevel,
      dynamic despeckleLevel,
      dynamic paths,
      dynamic cornersLevel}) {
    _numOfColors = numOfColors;
    _detailsLevel = detailsLevel;
    _despeckleLevel = despeckleLevel;
    _paths = paths;
    _cornersLevel = cornersLevel;
  }

  Vectorize numOfColors(dynamic numOfColors) {
    _numOfColors = numOfColors;
    return this;
  }

  Vectorize detailsLevel(dynamic detailsLevel) {
    _detailsLevel = detailsLevel;
    return this;
  }

  Vectorize despeckleLevel(dynamic despeckleLevel) {
    _despeckleLevel = despeckleLevel;
    return this;
  }

  Vectorize paths(dynamic paths) {
    _paths = paths;
    return this;
  }

  Vectorize cornersLevel(dynamic cornersLevel) {
    _cornersLevel = cornersLevel;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['vectorize'],
        separator: paramKeyValueSeparator).joinWithValues([
      ((_numOfColors != null) ? 'colors:$_numOfColors' : null),
      ((_detailsLevel != null) ? 'detail:$_detailsLevel' : null),
      ((_despeckleLevel != null) ? 'despeckle:$_despeckleLevel' : null),
      ((_paths != null) ? 'paths:$_paths' : null),
      ((_cornersLevel != null) ? 'corners:$_cornersLevel' : null)
    ]);
  }
}

class Outline extends Effect {
  dynamic _mode;
  Color? _color;
  int? _width;
  int? _blurLevel;

  Outline({dynamic mode, Color? color, int? width, int? blurLevel}) {
    _mode = mode;
    _color = color;
    _width = width.cldRange(1, 100);
    _blurLevel = blurLevel.cldRange(0, 200);
  }

  Outline mode(dynamic mode) {
    _mode = mode;
    return this;
  }

  Outline color(Color color) {
    _color = color;
    return this;
  }

  Outline colorWithString(String color) {
    _color = Color.parseString(color);
    return this;
  }

  Outline width(int width) {
    _width = width;
    return this;
  }

  Outline blurLevel(int blurLevel) {
    _blurLevel = blurLevel;
    return this;
  }

  @override
  String toString() {
    return asComponentString([
      ((_color != null) ? 'co_$_color' : null),
      super.toString().joinWithValues(['outline'],
          separator:
              paramKeyValueSeparator).joinWithValues(
          [_mode, _width, _blurLevel])
    ]);
  }
}

class Artistic extends Effect {
  ArtisticFilter filter;

  Artistic(this.filter);

  @override
  String toString() {
    return super.toString().joinWithValues(['art'],
        separator: paramKeyValueSeparator).joinWithValues([filter]);
  }
}

class ArtisticFilter {
  String value;

  ArtisticFilter(this.value);

  static alDente() => ArtisticFilter("al_dente");
  static athena() => ArtisticFilter("athena");
  static audrey() => ArtisticFilter("audrey");
  static aurora() => ArtisticFilter("aurora");
  static daguerre() => ArtisticFilter("daguerre");
  static eucalyptus() => ArtisticFilter("eucalyptus");
  static fes() => ArtisticFilter("fes");
  static frost() => ArtisticFilter("frost");
  static hairspray() => ArtisticFilter("hairspray");
  static hokusai() => ArtisticFilter("hokusai");
  static incognito() => ArtisticFilter("incognito");
  static linen() => ArtisticFilter("linen");
  static peacock() => ArtisticFilter("peacock");
  static primavera() => ArtisticFilter("primavera");
  static quartz() => ArtisticFilter("quartz");
  static redRock() => ArtisticFilter("red_rock");
  static refresh() => ArtisticFilter("refresh");
  static sizzle() => ArtisticFilter("sizzle");
  static sonnet() => ArtisticFilter("sonnet");
  static ukulele() => ArtisticFilter("ukulele");
  static zorro() => ArtisticFilter("zorro");

  @override
  String toString() {
    return value;
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

class OutlineMode {
  String value;

  OutlineMode(this.value);

  static inner() => OutlineMode("inner");
  static innerFill() => OutlineMode("inner_fill");
  static outer() => OutlineMode("outer");
  static fill() => OutlineMode("fill");

  @override
  String toString() {
    return value;
  }
}
