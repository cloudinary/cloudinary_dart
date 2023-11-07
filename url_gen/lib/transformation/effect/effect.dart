import '../color.dart';
import '../common.dart';
import '../region.dart';
import 'effect_actions.dart';
import 'objects/foreground_object.dart';

class Effect extends Action {
  /// Changes the color scheme of the image to sepia.
  ///
  /// Receives [dynamic] object and returns [Effect].
  static Sepia sepia([dynamic level]) {
    return Sepia(level);
  }

  /// Changes the speed of the video playback.
  ///
  /// Receives [dynamic] object returns [Effect]
  static Accelerate accelerate([dynamic rate]) {
    return Accelerate(rate);
  }

  /// Removes small motion shifts from the video. with a maximum extent of movement in the horizontal and vertical
  /// direction of 32 pixels
  /// Receives [ShakeStrength] object returns [Effect]
  static Deshake deshake([ShakeStrength? factor]) {
    return Deshake(factor);
  }

  /// Plays the video or audio file in reverse.
  /// returns [Effect]
  static Reverse reverse() {
    return Reverse();
  }

  /// Causes a video clip to play forwards and then backwards.
  ///
  /// Use in conjunction with trimming qualifiers ('duration', 'start_offset', or 'end_offset') and the 'loop' effect
  /// to deliver a classic (short, repeating) boomerang clip.
  /// For details and examples, see 'Create a boomerang video clip' in the Video Transformations guide.
  /// see https://cloudinary.com/documentation/video_manipulation_and_delivery#create_a_boomerang_video_clip
  /// returns [Effect]
  static Boomerang boomerang() {
    return Boomerang();
  }

  /// Adds visual noise to the video, visible as a random flicker of "dots" or "snow".
  ///
  /// returns [Effect]
  static Noise noise([dynamic level]) {
    return Noise(level);
  }

  /// Makes the background of the image transparent (or solid white for formats that do not support transparency).
  /// The background is determined as all pixels that resemble the pixels on the edges of the image.
  ///
  /// Receives [dynamic], [dynamic] returns [Effect]
  static MakeTransparent makeTransparent(
      {dynamic tolerance, dynamic colorToReplace}) {
    return MakeTransparent(
        tolerance: tolerance, colorToReplace: colorToReplace);
  }

  /// Fade in at the beginning of the video.
  ///
  /// For details and examples, see 'Fade in and out' in the Video Transformations guide.
  /// see https://cloudinary.com/documentation/video_manipulation_and_delivery#fade_in_and_out
  /// Receives [int] returns [Effect]
  static FadeIn fadeIn([int? duration]) {
    return FadeIn(duration);
  }

  /// Fade out at the end of the video.
  ///
  /// For details and examples, see 'Fade in and out' in the Video Transformations guide.
  /// see https://cloudinary.com/documentation/video_manipulation_and_delivery#fade_in_and_out
  /// Receives [int] returns [Effect]
  static FadeOut fadeOut([int? duration]) {
    return FadeOut(duration);
  }

  /// Delivers an animated GIF that contains additional loops of the GIF.
  ///
  /// The total number of iterations is the number of additional loops plus one.
  ///
  /// You can also specify the loop effect without a numeric value to instruct it to loop the GIF infinitely.
  /// Receives [int] returns [Effect]
  static Loop loop([int? additionalIterations]) {
    return Loop(additionalIterations);
  }

  /// Converts the image to black and white.
  ///
  /// Receives [dynamic] object returns [Effect].
  static Blackwhite blackwhite([dynamic threshold]) {
    return Blackwhite(threshold);
  }

  /// Applies an ordered dither filter to the image.
  ///
  /// Use the constants defined in \Cloudinary\Transformation\OrderedDither for $level.
  /// Receives [DitherObject] object returns [Effect].
  static Dither dither([DitherObject? filter]) {
    return Dither(filter);
  }

  /// Applies a vignette effect.
  /// Receives [dynamic] object returns [Effect].
  static Vignette vignette([dynamic strength]) {
    return Vignette(strength);
  }

  /// Simulates the way an image would appear to someone with the specified color blind condition.
  ///
  /// For a list of supported color blind conditions see the \Cloudinary\Transformation\SimulateColorBlind class.
  ///
  /// Receives [SimulateColorBlindObject] object returns [Effect].
  static SimulateColorBlind simulateColorBlind(
      [SimulateColorBlindObject? condition]) {
    return SimulateColorBlind(condition);
  }

  ///  Applies a cartoon effect to an image.
  /// Receives [dynamic], [dynamic], [bool] returns [Effect].
  static Cartoonify cartoonify(
      {dynamic lineStrength, dynamic colorReductionLevel, bool? blackwhite}) {
    return Cartoonify(
        lineStrength: lineStrength,
        colorReductionLevel: colorReductionLevel,
        blackwhite: blackwhite);
  }

  /// Adds a shadow to the image.
  ///
  /// Receives [dynamic], [Color], [dynamic], [dynamic] returns [Effect].
  static Shadow shadow(
      {dynamic strength, Color? color, dynamic offsetX, dynamic offsetY}) {
    return Shadow(
        strength: strength, color: color, offsetX: offsetX, offsetY: offsetY);
  }

  /// Vectorizes the image.
  ///
  /// Notes:
  /// To deliver the image as a vector image, make sure to change the format (or URL extension) to a vector format,
  /// such as SVG. However, you can also deliver in a raster format if you just want to get the 'vectorized'
  ///  graphic effect.
  /// Large images are scaled down to 1000 pixels in the largest dimension before vectorization.
  /// Receives [dynamic], [dynamic], [dynamic], [dynamic] returns [Effect].
  static Vectorize vectorize(
      {dynamic numOfColors,
      dynamic detailsLevel,
      dynamic despeckleLevel,
      dynamic paths,
      dynamic cornersLevel}) {
    return Vectorize(
        detailsLevel: detailsLevel,
        despeckleLevel: despeckleLevel,
        paths: paths,
        cornersLevel: cornersLevel);
  }

  /// Adds an outline to a transparent image.
  ///
  /// For examples, see the Image Transformations guide.
  /// see https://cloudinary.com/documentation/image_transformations#outline_effects
  /// /// Receives [dynamic], [Color], [int], [int] object returns [Effect].
  static Outline outline(
      {dynamic mode, Color? color, int? width, int? blurLevel}) {
    return Outline(
        mode: mode, color: color, width: width, blurLevel: blurLevel);
  }

  /// Applies the selected artistic filter to the image.
  ///
  /// See the Image Transformations guide for examples of each of the filters.
  ///
  /// filter The filter to apply. Use the constants defined in the ArtisticFilter class.
  static Artistic artisticFilter(ArtisticFilter filter) {
    return Artistic(filter);
  }

  /// Negates the image colors (negative).
  /// returns [Effect]
  static Negate negate() {
    return Negate();
  }

  /// Removes red eyes in the image.
  /// returns [Effect]
  static RedEye redEye() {
    return RedEye();
  }

  /// Converts the image to gray-scale (multiple shades of gray).
  /// returns [Effect]
  static Grayscale grayscale() {
    return Grayscale();
  }

  /// Applies an oil painting effect to the image.
  ///
  /// Receives [dynamic] object and returns [Effect]
  static OilPaint oilPaint([dynamic strength]) {
    return OilPaint(strength);
  }

  /// Removes red eyes with the Advanced Facial Attribute Detection add-on.
  ///
  /// For details, see the Advanced Facial Attribute Detection add-on documentation.
  /// see https://cloudinary.com/documentation/advanced_facial_attributes_detection_addon
  static AdvancedRedEye advancedRedEye() {
    return AdvancedRedEye();
  }

  /// Applies a pixelation effect to the image.
  /// Receives [dynamic], [Region] object and returns [Effect]
  static Pixelate pixelate({dynamic squareSize, Region? region}) {
    return Pixelate(squareSize: squareSize, region: region);
  }

  /// Applies a blurring filter to the asset.
  /// Receives [dynamic], [Region] object and returns [Effect]
  static Blur blur({dynamic strength, Region? region}) {
    return Blur(strength: strength, region: region);
  }

  /// Colorizes the image.
  ///
  /// Receives [dynamic], [Color] returns [Effect].
  static Colorize colorize({dynamic level, Color? color}) {
    return Colorize(level: level, color: color);
  }

  /// Applies a gradient fade effect from the top edge of the image.
  ///
  /// You can specify other edges using the x and y methods of the \Cloudinary\Transformation\GradientFade class.
  /// Receives [dynamic], [dynamic], [dynamic], [dynamic] returns [Effect].
  static GradientFade gradientFade(
      {dynamic strength,
      dynamic type,
      dynamic horizontalStartPoint,
      dynamic verticalStartPoint}) {
    return GradientFade(
        strength: strength,
        type: type,
        horizontalStartPoint: horizontalStartPoint,
        verticalStartPoint: verticalStartPoint);
  }

  /// Applies stripes to the image to help people with common color-blind conditions to differentiate between colors
  /// that are similar for them.
  ///
  /// You can replace colors using the xRay() method of the \Cloudinary\Transformation\AssistColorBlind class.
  ///
  /// Receives [dynamic], [AssistColorBlindType] object returns [Effect].
  static AssistColorBlind assistColorBlind(
      {dynamic strength, AssistColorBlindType? type}) {
    return AssistColorBlind(strength: strength, type: type);
  }

  /// Changes the main background color to the one specified, as if a 'theme change' was applied
  /// (e.g. dark mode vs light mode).
  ///
  /// @see https://cloudinary.com/documentation/transformation_reference#e_theme
  /// Receives [Color], [int] returns [Effect].
  static Theme theme(Color color, {int? photosensitivity}) {
    return Theme(color, photosensitivity: photosensitivity);
  }

  /// Makes the background of an image transparent (or solid white for JPGs).
  ///
  /// Use when the background is a uniform color.
  /// Receives [RemoveBackground] object returns [Effect].
  static RemoveBackground removeBackground({bool? screen, Color? color}) {
    return RemoveBackground(screen: screen, color: color);
  }

  static DropShadow dropShadow({int? azimuth, int? elevation, int? spread}) {
    return DropShadow(azimuth: azimuth, elevation: elevation, spread: spread);
  }

  static BackgroundRemoval backgroundRemoval(
      {bool? fineEdges, List<ForegroundObject>? hints}) {
    return BackgroundRemoval(fineEdges: fineEdges, hints: hints);
  }

  static ZoomPan zoomPan({ZoomPanMode? mode, int? maxZoom, int? duration}) {
    return ZoomPan(mode: mode, maxZoom: maxZoom, duration: duration);
  }

  static GenerativeRecolor generativeRecolor(dynamic prompt,
      {Color? toColor, bool? multiple}) {
    return GenerativeRecolor(prompt, toColor: toColor, multiple: multiple);
  }

  static GenerativeRemove generativeRemove(dynamic prompt,
      {bool? multiple, dynamic region, bool? removeShadow}) {
    return GenerativeRemove(prompt, multiple: multiple, region: region, removeShadow: removeShadow);
  }

  static GenerativeReplace generativeReplace({required String from, required String to, bool? preserveGeometry}) {
    return GenerativeReplace(from,to, preserveGeometry: preserveGeometry);
  }

  static GenerativeRestore generativeRestore() {
    return GenerativeRestore();
  }

  @override
  String toString() {
    return 'e';
  }
}
