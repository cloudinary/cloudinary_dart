import '../common.dart';
import 'effect_actions.dart';

class Effect extends Action {

  /// Changes the color scheme of the image to sepia.
  ///
  /// Receives [Sepia] object and returns [Effect].
  static Effect sepia([Sepia? sepia]) {
    return sepia ?? Sepia();
  }

  /// Changes the speed of the video playback.
  ///
  /// Receives [Accelerate] object returns [Effect]
  static Effect accelerate([Accelerate? accelerate]) {
    return accelerate ?? Accelerate();
  }

  /// Removes small motion shifts from the video. with a maximum extent of movement in the horizontal and vertical
  /// direction of 32 pixels
  /// Receives [Deshake] object returns [Effect]
  static Effect deshake([Deshake? deshake]) {
    return deshake ?? Deshake();
  }

  /// Plays the video or audio file in reverse.
  /// Receives [Reverse] object returns [Effect]
  static Effect reverse([Reverse? reverse]) {
    return reverse ?? Reverse();
  }
  /// Causes a video clip to play forwards and then backwards.
  ///
  /// Use in conjunction with trimming qualifiers ('duration', 'start_offset', or 'end_offset') and the 'loop' effect
  /// to deliver a classic (short, repeating) boomerang clip.
  /// For details and examples, see 'Create a boomerang video clip' in the Video Transformations guide.
  /// see https://cloudinary.com/documentation/video_manipulation_and_delivery#create_a_boomerang_video_clip
  /// Receives [Boomerang] object returns [Effect]
  static Effect boomerang([Boomerang? boomerang]) {
    return boomerang ?? Boomerang();
  }
  /// Adds visual noise to the video, visible as a random flicker of "dots" or "snow".
  ///
  /// Receives [Noise] object returns [Effect]
  static Effect noise([Noise? noise]) {
    return noise ?? Noise();
  }

  /// Makes the background of the image transparent (or solid white for formats that do not support transparency).
  /// The background is determined as all pixels that resemble the pixels on the edges of the image.
  ///
  /// Receives [MakeTransparent] object returns [Effect]
  static Effect makeTransparent([MakeTransparent? makeTransparent]) {
    return makeTransparent ?? MakeTransparent();
  }

  /// Fade in at the beginning of the video.
  ///
  /// For details and examples, see 'Fade in and out' in the Video Transformations guide.
  /// see https://cloudinary.com/documentation/video_manipulation_and_delivery#fade_in_and_out
  /// Receives [FadeIn] object returns [Effect]
  static Effect fadeIn([FadeIn? fadeIn]) {
    return fadeIn ?? FadeIn();
  }

  /// Fade out at the end of the video.
  ///
  /// For details and examples, see 'Fade in and out' in the Video Transformations guide.
  /// see https://cloudinary.com/documentation/video_manipulation_and_delivery#fade_in_and_out
  /// Receives [FadeOut] object returns [Effect]
  static Effect fadeOut([FadeOut? fadeOut]) {
    return fadeOut ?? FadeOut();
  }

  /// Delivers an animated GIF that contains additional loops of the GIF.
  ///
  /// The total number of iterations is the number of additional loops plus one.
  ///
  /// You can also specify the loop effect without a numeric value to instruct it to loop the GIF infinitely.
  /// Receives [Loop] object returns [Effect]
  static Effect loop([Loop? loop]) {
    return loop ?? Loop();
  }

  /// Converts the image to black and white.
  ///
  /// Receives [Blackwhite] object returns [Effect].
  static Effect blackwhite([Blackwhite? blackWhite]) {
    return blackWhite ?? Blackwhite();
  }

  /// Applies an ordered dither filter to the image.
  ///
  /// Use the constants defined in \Cloudinary\Transformation\OrderedDither for $level.
  /// Receives [Dither] object returns [Effect].
  static Effect dither([Dither? dither]) {
    return dither ?? Dither();
  }

  /// Applies a vignette effect.
  /// Receives [Vignette] object returns [Effect].
  static Effect vignette([Vignette? vignette]) {
    return vignette ?? Vignette();
  }

  /// Simulates the way an image would appear to someone with the specified color blind condition.
  ///
  /// For a list of supported color blind conditions see the \Cloudinary\Transformation\SimulateColorBlind class.
  ///
  /// Receives [SimulateColorBlind] object returns [Effect].
  static Effect simulateColorBlind([SimulateColorBlind? simulateColorBlind]) {
    return simulateColorBlind ?? SimulateColorBlind();
  }

  ///  Applies a cartoon effect to an image.
  /// Receives [Cartoonify] object returns [Effect].
  static Effect cartoonify([Cartoonify? cartoonify]) {
    return cartoonify ?? Cartoonify();
  }

  /// Adds a shadow to the image.
  ///
  /// Receives [Shadow] object returns [Effect].
  static Effect shadow([Shadow? shadow]) {
    return shadow ?? Shadow();
  }

  /// Vectorizes the image.
  ///
  /// Notes:
  /// To deliver the image as a vector image, make sure to change the format (or URL extension) to a vector format,
  /// such as SVG. However, you can also deliver in a raster format if you just want to get the 'vectorized'
  ///  graphic effect.
  /// Large images are scaled down to 1000 pixels in the largest dimension before vectorization.
  /// Receives [Vectorize] object returns [Effect].
  static Effect vectorize([Vectorize? vectorize]) {
    return vectorize ?? Vectorize();
  }

  /// Adds an outline to a transparent image.
  ///
  /// For examples, see the Image Transformations guide.
  /// see https://cloudinary.com/documentation/image_transformations#outline_effects
  /// /// Receives [Outline] object returns [Effect].
  static Effect outline([Outline? outline]) {
    return outline ?? Outline();
  }

  /// Applies the selected artistic filter to the image.
  ///
  /// See the Image Transformations guide for examples of each of the filters.
  ///
  /// @param string $filter The filter to apply. Use the constants defined in the ArtisticFilter class.
  static Effect artisticFilter(ArtisticFilter filter) {
    return Artistic(filter);
  }

  /// Negates the image colors (negative).
  /// Receives [Negate] object and returns [Effect]
  static Effect negate([Negate? negate]) {
    return negate ?? Negate();
  }

  /// Removes red eyes in the image.
  /// Receives [RedEye] object and returns [Effect]
  static Effect redEye([RedEye? redEye]) {
    return redEye ?? RedEye();
  }

  /// Converts the image to gray-scale (multiple shades of gray).
  /// Receives [Grayscale] object and returns [Effect]
  static Effect grayscale([Grayscale? grayscale]) {
    return grayscale ?? Grayscale();
  }

  /// Applies an oil painting effect to the image.
  ///
  /// Receives [OilPaint] object and returns [Effect]
  static Effect oilPaint([OilPaint? oilPaint]) {
    return oilPaint ?? OilPaint();
  }

  /// Removes red eyes with the Advanced Facial Attribute Detection add-on.
  ///
  /// For details, see the Advanced Facial Attribute Detection add-on documentation.
  /// see https://cloudinary.com/documentation/advanced_facial_attributes_detection_addon
  static Effect advancedRedEye([AdvancedRedEye? advancedRedEye]) {
    return advancedRedEye ?? AdvancedRedEye();
  }

  /// Applies a pixelation effect to the image.
  /// Receives [Pixelate] object and returns [Effect]
  static Effect pixelate([Pixelate? pixelate]) {
    return pixelate ?? Pixelate();
  }

  /// Applies a blurring filter to the asset.
  /// Receives [Blur] object and returns [Effect]
  static Effect blur([Blur? blur]) {
    return blur ?? Blur();
  }

  /// Colorizes the image.
  ///
  /// Receives [Colorize] object returns [Effect].
  static Effect colorize([Colorize? colorize]) {
    return colorize ?? Colorize();
  }

  /// Applies a gradient fade effect from the top edge of the image.
  ///
  /// You can specify other edges using the x and y methods of the \Cloudinary\Transformation\GradientFade class.
  /// Receives [GradientFade] object returns [Effect].
  static Effect gradientFade([GradientFade? gradientFade]) {
    return gradientFade ?? GradientFade();
  }

  /// Applies stripes to the image to help people with common color-blind conditions to differentiate between colors
  /// that are similar for them.
  ///
  /// You can replace colors using the xRay() method of the \Cloudinary\Transformation\AssistColorBlind class.
  ///
  /// Receives [AsistColorBlind] object returns [Effect].
  static Effect assistColorBlind([AssistColorBlind? assistColorBlind]) {
    return assistColorBlind ?? AssistColorBlind();
  }

  /// Changes the main background color to the one specified, as if a 'theme change' was applied
  /// (e.g. dark mode vs light mode).
  ///
  /// @see https://cloudinary.com/documentation/transformation_reference#e_theme
  /// Receives [Theme] object returns [Effect].
  static Effect theme(Theme theme) {
    return theme;
  }

  /// Makes the background of an image transparent (or solid white for JPGs).
  ///
  /// Use when the background is a uniform color.
  /// Receives [RemoveBackground] object returns [Effect].
  static Effect removeBackground([RemoveBackground? removeBackground]) {
    return removeBackground ?? RemoveBackground();
  }

  @override
  String toString() {
    return 'e';
  }
}
