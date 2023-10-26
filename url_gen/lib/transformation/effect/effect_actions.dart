import 'dart:core';

import 'package:cloudinary_url_gen/src/extensions/string_extension.dart';
import 'package:cloudinary_url_gen/src/util/validations.dart';

import '../coordinates/coordinates.dart';
import '../gravity/gravity.dart';
import '../transformation_utils.dart';
import '../color.dart';
import '../common.dart';
import '../region.dart';
import 'effect.dart';
import 'objects/foreground_object.dart';

/// Class Sepia
/// level The level of sepia to apply. (Range: 1 to 100, Server default: 80)
class Sepia extends Effect {
  dynamic level;

  Sepia([this.level]);

  @override
  String toString() {
    return super.toString().joinWithValues(['sepia'],
        actionSeparator: paramKeyValueSeparator).joinWithValues([level]);
  }
}

/// Class Accelerate
/// rate  The percentage change of speed. Positive numbers speed up the playback, negative numbers
/// slow down the playback (Range: -50 to 100, Server default: 0).
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([_rate]);
  }
}

class Deshake extends Effect {
  ShakeStrength? factor;

  Deshake([this.factor]);

  /// shakeStrength   The maximum number of pixels in the horizontal and vertical direction that will be
  /// addressed. (Possible values: 16, 32, 48, 64. Server default: 16)
  Deshake shakeStrength(ShakeStrength shakeStrength) {
    factor = shakeStrength;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['deshake'],
        actionSeparator: paramKeyValueSeparator).joinWithValues([factor]);
  }
}

class Reverse extends Effect {
  @override
  String toString() {
    return super
        .toString()
        .joinWithValues(['reverse'], actionSeparator: paramKeyValueSeparator);
  }
}

class Boomerang extends Effect {
  @override
  String toString() {
    return super
        .toString()
        .joinWithValues(['boomerang'], actionSeparator: paramKeyValueSeparator);
  }
}

/// Class MakeTransparent
/// tolerance The tolerance used to accommodate variance in the background color.
/// (Range: 0 to 100, Server default: 10)
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
        actionSeparator:
            paramKeyValueSeparator).joinWithValues(
        [_tolerance]).joinWithValues([
      (_colorToReplace != null ? 'co_'.joinWithValues([_colorToReplace]) : null)
    ]);
  }
}

/// Class FadeIn
/// duration The time in ms for the fade to occur. (Server default: 1000)
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([_duration]);
  }
}

/// Class FadeOut
/// duration The time in ms for the fade to occur.
class FadeOut extends Effect {
  int? _duration;

  FadeOut([int? duration]) {
    _duration = duration;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['fade'],
        actionSeparator:
            paramKeyValueSeparator).joinWithValues(['-$_duration']);
  }
}

/// Class Loop
/// additionalIterations The additional number of times to play the animated GIF.
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
        actionSeparator:
            paramKeyValueSeparator).joinWithValues([_additionalIterations]);
  }
}

/// Class Blacwhite
/// threshold (Range: 0 to 100, Server default: 50)
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([_threshold]);
  }
}

/// Class Dither
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([filter]);
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([_strength]);
  }
}

/// Class SimulateColorBlind
/// condition The color blind condition. Use the constants defined in the SimulateColorBlind class.
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([_condition]);
  }
}

/// Class Cartoonify
/// lineStrength   The thickness of the lines. (Range: 0 to 100, Server default: 50)
/// colorReduction The decrease in the number of colors and corresponding saturation boost of
/// the remaining colors. (Range: 0 to 100, Server default: automatically
/// adjusts according to the line_strength value). Higher reduction values
/// result in a less realistic look.
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
        actionSeparator:
            paramKeyValueSeparator).joinWithValues(
        [_lineStrength, ((_blackwhite) ? 'bw' : _colorReductionLevel)]);
  }
}

/// Class Shadow
/// The shadow is offset by the x and y values specified in the $position qualifier.
///
/// strength The strength of the shadow. (Range: 0 to 100, Server default: 40)
/// position The position of the shadow. (Server default: bottom right)
/// color    The color of the shadow (Server default: gray)
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
          actionSeparator:
              paramKeyValueSeparator).joinWithValues(
          [_strength]).joinWithValues([
        ((_offsetX != null) ? 'x_$_offsetX' : null),
        ((_offsetY != null) ? 'y_$_offsetY' : null)
      ], separator: paramSeparator, actionSeparator: paramSeparator)
    ]);
  }
}

/// Class Vectorize
/// colors    The number of colors. (Range: 2 to 30, Server default: 10)
/// detail    The level of detail. Specify either a percentage of the original image (Range: 0.0 to
/// 1.0) or an absolute number of pixels (Range: 0 to 1000). (Server default: 300)
/// The size of speckles to suppress. Specify either a percentage of the original image
/// (Range: 0.0 to 1.0) or an absolute number of pixels (Range: 0 to 100, Server default: 2)
/// The corner threshold.  Specify 100 for no smoothing (polygon corners), 0 for completely
/// smooth corners. (Range: 0 to 100, Default: 25)
/// The optimization value. Specify 100 for least optimization and the largest file.
/// (Range: 0 to 100, Server default: 100).
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([
      ((_numOfColors != null) ? 'colors:$_numOfColors' : null),
      ((_detailsLevel != null) ? 'detail:$_detailsLevel' : null),
      ((_despeckleLevel != null) ? 'despeckle:$_despeckleLevel' : null),
      ((_paths != null) ? 'paths:$_paths' : null),
      ((_cornersLevel != null) ? 'corners:$_cornersLevel' : null)
    ]);
  }
}

/// Class Outline
/// mode      The type of outline effect. Use the constants defined in the Outline class.
/// (Default: OutlineMode.inner() and OutlineMode.outer()).
/// width     The thickness of the outline in pixels. (Range: 1 to 100, Server default: 5)
/// blurLevel The level of blur of the outline. (Range: 0 to 2000, Server default: 0)
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
          actionSeparator:
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
        actionSeparator: paramKeyValueSeparator).joinWithValues([filter]);
  }
}

class Negate extends Effect {
  @override
  String toString() {
    return super
        .toString()
        .joinWithValues(['negate'], actionSeparator: paramKeyValueSeparator);
  }
}

class RedEye extends Effect {
  @override
  String toString() {
    return super
        .toString()
        .joinWithValues(['redeye'], actionSeparator: paramKeyValueSeparator);
  }
}

class Grayscale extends Effect {
  @override
  String toString() {
    return super
        .toString()
        .joinWithValues(['grayscale'], actionSeparator: paramKeyValueSeparator);
  }
}

/// Class OilPaint
/// strength The strength of the effect. (Range: 0 to 100, Server default: 30)
class OilPaint extends Effect {
  dynamic _strength;

  OilPaint([dynamic strength]) {
    _strength = strength;
  }

  OilPaint strength(dynamic strength) {
    _strength = strength;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['oil_paint'],
        actionSeparator: paramKeyValueSeparator).joinWithValues([_strength]);
  }
}

class AdvancedRedEye extends Effect {
  @override
  String toString() {
    return super.toString().joinWithValues(['adv_redeye'],
        actionSeparator: paramKeyValueSeparator);
  }
}

/// Class Pixelate
/// squareSize The width of each pixelation square in pixels.  (Range: 1 to 200, Server default: 5)
class Pixelate extends Effect {
  dynamic _squareSize;
  Region? _region;

  Pixelate({dynamic squareSize, Region? region}) {
    _squareSize = squareSize;
    _region = region;
  }

  Pixelate squareSize(dynamic squareSize) {
    _squareSize = squareSize;
    return this;
  }

  Pixelate region(Region region) {
    _region = region;
    return this;
  }

  @override
  String toString() {
    var parent = super
        .toString()
        .joinWithValues(['pixelate'], actionSeparator: paramKeyValueSeparator);
    if (_region != null) {
      if (_region is Faces) {
        return parent.joinWithValues([_region],
            actionSeparator:
                paramKeyValueSeparator).joinWithValues([_squareSize]);
      }
      return parent +
          '_region'.joinWithValues([_squareSize]).joinWithValues([_region],
              separator: paramSeparator, actionSeparator: paramSeparator);
    }
    return parent.joinWithValues([_squareSize]);
  }
}

/// Class Blur
/// strength The strength of the blur. (Range: 1 to 2000, Server default: 100)
class Blur extends Effect {
  dynamic _strength;
  Region? _region;

  Blur({dynamic strength, Region? region}) {
    _strength = strength;
    _region = region;
  }

  Blur strength(dynamic strength) {
    _strength = strength;
    return this;
  }

  Blur region(Region region) {
    _region = region;
    return this;
  }

  @override
  String toString() {
    var parent = super
        .toString()
        .joinWithValues(['blur'], actionSeparator: paramKeyValueSeparator);
    if (_region != null) {
      if (_region is Faces) {
        return parent.joinWithValues([_region],
            actionSeparator:
                paramKeyValueSeparator).joinWithValues([_strength]);
      }
      return parent +
          '_region'.joinWithValues([_strength]).joinWithValues([_region],
              actionSeparator: paramSeparator);
    }
    return parent.joinWithValues([_strength]);
  }
}

/// Class Colorize
/// level The strength of the color. (Range: 0 to 100, Server default: 100)
/// color The color to use for colorization.  Specify HTML name or RGB hex code.
/// (Server default: gray)
class Colorize extends Effect {
  dynamic _level;
  Color? _color;

  Colorize({dynamic level, Color? color}) {
    _level = level;
    _color = color;
  }

  Colorize level(dynamic level) {
    _level = level;
    return this;
  }

  Colorize color(Color color) {
    _color = color;
    return this;
  }

  @override
  String toString() {
    return asComponentString([
      ((_color != null) ? 'co_$_color' : null),
      super.toString().joinWithValues(['colorize'],
          actionSeparator: paramKeyValueSeparator).joinWithValues([_level])
    ]);
  }
}

/// Class GradientFade
/// strength The strength of the fade effect. (Range: 0 to 100, Server default: 20)
/// type     The type of gradient fade: GradientFade::SYMMETRIC or GradientFade::SYMMETRIC_PAD.
class GradientFade extends Effect {
  dynamic _strength;
  dynamic _type;
  dynamic _horizontalStartPoint;
  dynamic _verticalStartPoint;

  GradientFade(
      {dynamic strength,
      dynamic type,
      dynamic horizontalStartPoint,
      dynamic verticalStartPoint}) {
    _strength = strength;
    _type = type;
    _horizontalStartPoint = horizontalStartPoint;
    _verticalStartPoint = verticalStartPoint;
  }

  GradientFade strength(dynamic strength) {
    _strength = strength;
    return this;
  }

  GradientFade type(dynamic type) {
    _type = type;
    return this;
  }

  GradientFade horizontalStartPoint(dynamic horizontalStartPoint) {
    _horizontalStartPoint = horizontalStartPoint;
    return this;
  }

  GradientFade verticalStartPoint(dynamic verticalStartPoint) {
    _verticalStartPoint = verticalStartPoint;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['gradient_fade'],
        actionSeparator:
            paramKeyValueSeparator).joinWithValues(
        [_type, _strength, _horizontalStartPoint, _verticalStartPoint]);
  }
}

/// Class AsistColorBlind
/// strength The strength of the stripes.  (Range: 1 to 100, Server default: 10)
class AssistColorBlind extends Effect {
  dynamic _strength;
  AssistColorBlindType? _type;

  AssistColorBlind({dynamic strength, AssistColorBlindType? type}) {
    _strength = strength;
    _type = type;
  }

  AssistColorBlind stripesStrength(dynamic strength) {
    _type = AssistColorBlindType.stripes;
    _strength = strength;
    return this;
  }

  AssistColorBlind xray() {
    _type = AssistColorBlindType.xray;
    _strength = null;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['assist_colorblind'],
        actionSeparator:
            paramKeyValueSeparator).joinWithValues(
        [_strength, (_type == AssistColorBlindType.xray) ? 'xray' : null]);
  }
}

class Theme extends Effect {
  final Color _color;
  int? _photosensitivity;

  Theme(this._color, {int? photosensitivity}) {
    _photosensitivity = photosensitivity;
  }

  Theme photosensitivity(int photosensitivity) {
    _photosensitivity = photosensitivity;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['theme'],
        actionSeparator: paramKeyValueSeparator).joinWithValues([
      'color_$_color',
      (_photosensitivity != null) ? 'photosensitivity_$_photosensitivity' : null
    ]);
  }
}

/// Class BackgroundRemoval
/// fineedges
/// hints - objects to search for. (List can be found in [ForegroundObject])
class BackgroundRemoval extends Effect {
  bool? _fineEdges;
  List<ForegroundObject>? _hints;

  BackgroundRemoval({bool? fineEdges, List<ForegroundObject>? hints}) {
    _fineEdges = fineEdges;
    _hints = hints;
  }

  BackgroundRemoval fineEdges(bool fineEdges) {
    _fineEdges = fineEdges;
    return this;
  }

  BackgroundRemoval hints(List<ForegroundObject> hints) {
    _hints = hints;
    return this;
  }

  @override
  String toString() {
    return 'e_background_removal'.joinWithValues([
      (_fineEdges != null)
          ? ((_fineEdges == true) ? 'fineedges_y' : 'fineedges_n')
          : null,
      (_hints != null) ? 'hints_(${_hints!.join(';')})' : null
    ]);
  }
}

/// Class RemoveBackground
/// screen When true, provides better results for images with near perfect green/blue
/// background.
/// colorToRemove The background color as an RGB/A hex code. Overrides the algorithm's choice of
/// background color.
/// Default: The algorithm's choice - often the edge color of the image.
class RemoveBackground extends Effect {
  bool? _screen;
  Color? _colorToRemove;

  RemoveBackground({bool? screen, Color? color}) {
    _screen = screen;
    _colorToRemove = color;
  }

  RemoveBackground screen(bool screen) {
    _screen = screen;
    return this;
  }

  RemoveBackground colorToRemove(Color colorToRemove) {
    _colorToRemove = colorToRemove;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['bgremoval'],
        actionSeparator: paramKeyValueSeparator).joinWithValues([
      ((_screen != null) ? 'screen' : null),
      _colorToRemove?.toStringWithPrefix(false)
    ]);
  }
}

/// Class Noise
/// level The percent of noise to apply. (Range: 0 to 100 Server default: 0)
class Noise extends Effect {
  dynamic level;

  Noise([this.level]);

  @override
  String toString() {
    return super.toString().joinWithValues(['noise'],
        actionSeparator: paramKeyValueSeparator).joinWithValues([level]);
  }
}

/// Class Noise
/// Azimuth (range: 0 to 360 )
/// Elevation (range: 0 - 90 (degrees))
/// Spread (range 0 - 100)
class DropShadow extends Effect {
  int? _azimuth;
  int? _elevation;
  int? _spread;

  DropShadow({int? azimuth, int? elevation, int? spread}) {
    _azimuth = azimuth;
    _elevation = elevation;
    _spread = spread;
  }

  DropShadow azimuth(int azimuth) {
    _azimuth = azimuth;
    return this;
  }

  DropShadow elevation(int elevation) {
    _elevation = elevation;
    return this;
  }

  DropShadow spread(int spread) {
    _spread = spread;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['dropshadow'],
        actionSeparator: paramKeyValueSeparator).joinWithValues([
      (_azimuth != null) ? 'azimuth_$_azimuth' : null,
      (_elevation != null) ? 'elevation_$_elevation' : null,
      (_spread != null) ? 'spread_$_spread' : null
    ], separator: ';', actionSeparator: ':');
  }
}

class ZoomPan extends Effect {
  ZoomPanMode? _mode;
  int? _maxZoom;
  int? _duration;
  ZoomPanArea? _from;
  ZoomPanArea? _to;

  ZoomPan({
    ZoomPanMode? mode,
    int? maxZoom,
    int? duration,
  }) {
    _mode = mode;
    _maxZoom = maxZoom;
    _duration = duration;
  }

  ZoomPan mode(ZoomPanMode mode) {
    _mode = mode;
    return this;
  }

  ZoomPan maxZoom(int maxZoom) {
    _maxZoom = maxZoom;
    return this;
  }

  ZoomPan duration(int duration) {
    _duration = duration;
    return this;
  }

  ZoomPan from(ZoomPanArea from) {
    _from = ZoomPanAreaFrom(from);
    return this;
  }

  ZoomPan to(ZoomPanArea to) {
    _to = ZoomPanAreaTo(to);
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['zoompan'],
        actionSeparator: paramKeyValueSeparator).joinWithValues([
      (_mode != null ? 'mode_$_mode' : null),
      (_maxZoom != null ? 'maxzoom_$_maxZoom' : null),
      (_duration != null ? 'du_$_duration' : null),
      (_from != null ? '$_from' : null),
      (_to != null ? 'to_$_to' : null)
    ], separator: ';');
  }
}

class GenerativeRecolor extends Effect {
  dynamic _prompt;
  Color? _toColor;
  bool? _multiple;

  GenerativeRecolor(dynamic prompt, {Color? toColor, bool? multiple}) {
    _prompt = prompt;
    _toColor = toColor;
    _multiple = multiple;
  }

  GenerativeRecolor prompt(dynamic prompt) {
    _prompt = prompt;
    return this;
  }

  GenerativeRecolor toColor(dynamic toColor) {
    if (toColor is String) {
      _toColor = Color.parseString(toColor);
    } else {
      _toColor = toColor;
    }
    return this;
  }

  GenerativeRecolor multiple(bool multiple) {
    _multiple = multiple;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues(['gen_recolor'],
        actionSeparator: paramKeyValueSeparator).joinWithValues([
      (_prompt is List
          ? 'prompt_(${(_prompt as List<String>).join(';')})'
          : 'prompt_($_prompt)'),
      (_multiple != null ? 'multiple_$_multiple' : null),
      (_toColor != null ? 'to-color_$_toColor' : null)
    ], separator: newParamSeparator);
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

class GenerativeRemove extends Effect {
  dynamic _prompt;
  bool? _multiple;
  dynamic _region;

  GenerativeRemove(this._prompt, {bool? multiple, dynamic region}) {
    _multiple = multiple;
    _region = region;
  }

  GenerativeRemove multiple(bool multiple) {
    _multiple = multiple;
    return this;
  }

  GenerativeRemove region(dynamic region) {
    if (region is Rectangle || region is List<Rectangle>) {
      _region = region;
    }
    return this;
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

  static coneMonochromacy() => SimulateColorBlindObject("cone_monochromacy");

  static rodMonochromacy() => SimulateColorBlindObject("rod_monochromacy");

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

/// Class ArtisticFilter
/// value The filter to apply. Use the constants defined in the ArtisticFilter class.
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

enum AssistColorBlindType { stripes, xray }

class ZoomPanMode {
  String value;

  ZoomPanMode(this.value);

  static zoomInToCenter() => ZoomPanMode('ztc');
  static zoomInToLeft() => ZoomPanMode('ztl');
  static zoomInToRight() => ZoomPanMode('ztr');
  static zoomOutFromCenter() => ZoomPanMode('ofc');
  static zoomOutFromLeft() => ZoomPanMode('ofl');
  static zoomOutFromRight() => ZoomPanMode('ofr');
  static panLeftToRight() => ZoomPanMode('plr');
  static panRightToLeft() => ZoomPanMode('prl');

  @override
  String toString() {
    return value;
  }
}

class ZoomPanAreaFrom extends ZoomPanArea {
  ZoomPanAreaFrom(ZoomPanArea area) {
    super.type = 'from';
    super._gravity = area._gravity;
    super._zoom = area._zoom;
    super._x = area._x;
    super._y = area._y;
  }
}

class ZoomPanAreaTo extends ZoomPanArea {
  ZoomPanAreaTo(ZoomPanArea area) {
    super.type = 'to';
    super._gravity = area._gravity;
    super._zoom = area._zoom;
    super._x = area._x;
    super._y = area._y;
  }
}

class ZoomPanArea {
  late String type;
  Gravity? _gravity;
  int? _zoom;
  int? _x;
  int? _y;

  ZoomPanArea({Gravity? gravity, int? zoom, int? x, int? y}) {
    _gravity = gravity;
    _zoom = zoom;
    _x = x;
    _y = y;
  }

  ZoomPanArea gravity(Gravity gravity) {
    _gravity = gravity;
    return this;
  }

  ZoomPanArea zoom(int zoom) {
    _zoom = zoom;
    return this;
  }

  ZoomPanArea x(int x) {
    _x = x;
    return this;
  }

  ZoomPanArea y(int y) {
    _y = y;
    return this;
  }

  @override
  String toString() {
    return '${'$type('.joinWithValues([
          (_gravity != null ? 'g_$_gravity' : null),
          (_zoom != null ? 'zoom_$_zoom' : null),
          (_x != null ? 'x_$_x' : null),
          (_y != null ? 'y_$_y' : null),
        ], actionSeparator: '', separator: ';')})';
  }
}
