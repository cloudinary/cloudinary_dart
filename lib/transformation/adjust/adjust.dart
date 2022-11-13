import '../color.dart';
import '../common.dart';
import 'adjust_actions.dart';

class Adjust extends Action {
  /// Adjusts the opacity of the image and makes it semi-transparent.
  ///
  /// Receives level [dynamic] The level of opacity. 100 means opaque, while 0 is completely transparent.
  /// (Range: 0 to 100) return [Opacity]
  static Opacity opacity([dynamic level]) {
    return Opacity(level);
  }

  /// Blends the image with one or more tint colors at the intensity specified.
  ///
  /// Optional - equalize colors before tinting, specify gradient blend positioning per color.
  ///
  /// Receives qualifiers Syntax: [equalize]:[amount]:[color1]:[color1_position]:[color2]:[color2_position]:...
  /// [color10]:[color10_position] returns [Tint]
  static Tint tint([String? options]) {
    return Tint(options);
  }

  /// Applies a vibrance filter on the image.
  ///
  /// Receives strength [dynamic] The strength of the vibrance. (Range: -100 to 100, Server default: 20)
  /// Returns [LevelAdjust].
  static LevelAdjust vibrance([dynamic strength]) {
    return LevelAdjust('vibrance', strength);
  }

  /// Adjusts the color balance and blends the result with the original image.
  ///
  /// Receives blend [dynamic] How much to blend the adjusted color result, where 0 means only use the original and 100 means
  /// only use the adjusted color result. (Range: 0 to 100, Server default: 100) returns [AutoColor]
  static AutoColor autoColor([dynamic blend]) {
    return AutoColor(blend);
  }

  /// Adjusts the brightness.
  ///
  /// level [dynamic] The level of brightness (Range: -99 to 100, Server default: 80)
  /// Returns [LevelAdjust]
  static LevelAdjust brightness([dynamic level]) {
    return LevelAdjust('brightness', level);
  }

  /// Adjusts the brightness and blends the result with the original image.
  ///
  /// Receives blend How much to blend the adjusted brightness, where 0 means only use the original and 100 means
  /// only use the adjusted brightness result. (Range: 0 to 100, Server default: 100) returns [AutoBrightness]
  static AutoBrightness autoBrightness([dynamic blend]) {
    return AutoBrightness(blend);
  }

  /// Adjusts image brightness modulation in HSB to prevent artifacts in some images.
  ///
  /// @param int $level The level of modulation. (Range: -99 to 100, Server default: 80)
  /// Returns [LevelAdjust]
  static LevelAdjust brightnessHSB([dynamic level]) {
    return LevelAdjust('brightness_hsb', level);
  }

  /// Adjusts the contrast and blends the result with the original image.
  ///
  /// Receives blend [dynamic] How much to blend the adjusted contrast, where 0 means only use the original and 100 means
  /// only use the adjusted contrast result. (Range: 0 to 100, Server default: 100)
  /// Returns [AutoContrast]
  static AutoContrast autoContrast([dynamic blend]) {
    return AutoContrast(blend);
  }

  /// Applies an unsharp mask filter to the image.
  ///
  /// Receives strength [dynamic] The strength of the filter. (Range: 1 to 2000, Server default: 100)
  /// Returns [LevelAdjust]
  static LevelAdjust unsharpMask([dynamic strength]) {
    return LevelAdjust('unsharp_mask', strength);
  }

  /// Enhances an image to its best visual quality with the Viesus Automatic Image Enhancement add-on.
  ///
  /// For details, see the Viesus Automatic Image Enhancement add-on documentation.
  /// \Cloudinary\Transformation\ViesusCorrect
  /// https://cloudinary.com/documentation/viesus_automatic_image_enhancement_addon
  /// Receives noRedEye [bool] skinSaturation [bool] skinSaturiationLevel [int] returns [ViesusCorrect]
  static ViesusCorrect viesusCorrect(
      {bool? noRedEye, bool? skinSaturation, int? skinSaturationLevel}) {
    return ViesusCorrect(
        noRedEye: noRedEye,
        skinSaturation: skinSaturation,
        skinSaturationLevel: skinSaturationLevel);
  }

  /// Adjusts the image's hue.
  ///
  /// Receives level [dynamic] The level of hue. (Range: -100 to 100, Server default: 80)
  /// Returns [LevelAdjust]
  static LevelAdjust hue([dynamic level]) {
    return LevelAdjust('hue', level);
  }

  /// Adjusts the gamma level.
  ///
  /// Receives level [dynamic] The level of gamma (Range: -50 to 150, Server default: 0).
  /// Returns [LevelAdjust]
  static LevelAdjust gamma([dynamic level]) {
    return LevelAdjust('gamma', level);
  }

  /// Adjusts the contrast.
  ///
  /// level [dynamic] The level of contrast (Range: -100 to 100, Server default: 0)
  /// Returns [LevelAdjust]
  static LevelAdjust contrast([dynamic level]) {
    return LevelAdjust('contrast', level);
  }

  /// Adjusts the image's green channel.
  ///
  /// Receives level [dynamic] The level of green. (Range: -100 to 100, Server default: 0)
  /// Returns [LevelAdjust]
  static LevelAdjust green([dynamic level]) {
    return LevelAdjust('green', level);
  }

  /// Adjusts the image's blue channel.
  ///
  /// Receives level [dynamic] The level of blue. (Range: -100 to 100, Server default: 0)
  /// Returns [LevelAdjust]
  static LevelAdjust blue([dynamic level]) {
    return LevelAdjust('blue', level);
  }

  /// Adjusts the image's red channel.
  ///
  /// Receives level [dynamic] The level of red. (Range: -100 to 100, Server default: 0)
  /// Returns [LevelAdjust]
  static LevelAdjust red([dynamic level]) {
    return LevelAdjust('red', level);
  }

  /// Causes all semi-transparent pixels in an image to be either fully transparent or fully opaque.
  ///
  /// Each pixel with an opacity lower than the specified threshold value is set to an opacity of 0%. Each pixel with
  /// an opacity greater than the specified threshold is set to an opacity of 100%. For example, setting
  /// opacity_threshold:0 makes all pixels non-transparent, while opacity_threshold:100 makes all semi-transparent
  /// pixels fully transparent. Note: This effect can be a useful solution when PhotoShop PSD files are delivered in a
  /// format supporting partial transparency, such as PNG, and the results without this effect are not as expected.
  ///
  /// Receives level [dynamic] The level of the threshold. (Range: 1 to 100, Server default: 50)
  /// Returns [LevelAdjust]
  static LevelAdjust opacityThreshold([dynamic level]) {
    return LevelAdjust('opacity_threshold', level);
  }

  /// Adjusts the color saturation.
  ///
  /// level [dynamic] The level of color saturation (Range: -100 to 100, Server default: 80).
  /// Returns [LevelAdjust]
  static LevelAdjust saturation([dynamic level]) {
    return LevelAdjust('saturation', level);
  }

  /// Applies a sharpening filter to the image.
  ///
  /// Receives strength [dynamic] The strength of the filter. (Range: 1 to 2000, Server default: 100)
  /// Returns [Sharpen]
  static Sharpen sharpen([dynamic strength]) {
    return Sharpen(strength);
  }

  /// Maps an input color and those similar to the input color to corresponding shades of a specified output color,/
  /// taking luminosity and chroma into account, in order to recolor an object in a natural way.
  ///
  /// More highly saturated input colors usually give the best results. It is recommended to avoid input colors
  /// approaching white, black, or gray.
  ///
  /// Recives toColor   The HTML name or RGB/A hex code of the target output color.
  /// tolerance The tolerance threshold (a radius in the LAB color space) from the input color,
  /// representing the span of colors that should be replaced with a correspondingly adjusted
  /// version of the target output color. Larger values result in replacing more colors
  /// within the image. The more saturated the original input color, the more a change in
  /// value will impact the result (Server default: 50).
  /// fromColor The HTML name or RGB/A hex code of the base input color to map
  /// (Server default: the most prominent high-saturation color in the image).
  /// Returns [ReplaceColor]
  static ReplaceColor replaceColor(Color color,
      {int? tolerance, Color? fromColor}) {
    return ReplaceColor(color, tolerance: tolerance, fromColor: fromColor);
  }

  /// Converts the colors of every pixel in an image based on the supplied color matrix, in which the value of each
  /// color channel is calculated based on the values from all other channels (e.g. a 3x3 matrix for RGB, a 4x4 matrix
  /// for RGBA or CMYK, etc).
  ///
  /// For every pixel in the image, take each color channel and adjust its value by the
  /// specified values of the matrix to get a new value.
  ///
  /// Receives colorMatrix[List<List<double>>] The matrix of colors.
  /// Returns [Recolor]
  static Recolor recolor(List<List<double>> colorMatrix) {
    return Recolor(colorMatrix);
  }

  /// Adjusts the fill light and blends the result with the original image.
  ///
  /// blend [dynamic] How much to blend the adjusted fill light, where 0 means only use the original and 100 means
  /// only use the adjusted fill light result. Range: 0 to 100, Server default: 100)
  /// bias [dynamic] The bias to apply to the fill light effect (Range: -100 to 100, Server default: 0).
  /// Returns [FillLight]
  static FillLight fillLight({dynamic blend, dynamic bias}) {
    return FillLight(blend: blend, bias: bias);
  }

  /// Adjusts the image colors, contrast and brightness.
  ///
  /// Use the constants defined in \Cloudinary\Transformation\Improve for $mode.
  ///
  /// Receives blend [dynamic] How much to blend the improved result with the original image,
  /// where 0 means only use the original and 100 means only use the improved result.
  /// (Range: 0 to 100, Server default: 100)
  /// mode [ImproveMode] The improve mode. Use the constants defined in the Improve class.
  /// Returns [Improve]
  static Improve improve({ImproveMode? mode, int? blend}) {
    return Improve(mode: mode, blend: blend);
  }

  @override
  String toString() {
    return 'e';
  }
}
