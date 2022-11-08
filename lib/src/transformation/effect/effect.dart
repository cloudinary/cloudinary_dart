import '../common.dart';
import 'effect_actions.dart';

class Effect extends Action {
  static Effect sepia([Sepia? sepia]) {
    return sepia ?? Sepia();
  }

  static Effect accelerate([Accelerate? accelerate]) {
    return accelerate ?? Accelerate();
  }

  static Effect deshake([Deshake? deshake]) {
    return deshake ?? Deshake();
  }

  static Effect reverse([Reverse? reverse]) {
    return reverse ?? Reverse();
  }

  static Effect boomerang([Boomerang? boomerang]) {
    return boomerang ?? Boomerang();
  }

  static Effect noise([Noise? noise]) {
    return noise ?? Noise();
  }

  static Effect makeTransparent([MakeTransparent? makeTransparent]) {
    return makeTransparent ?? MakeTransparent();
  }

  static Effect fadeIn([FadeIn? fadeIn]) {
    return fadeIn ?? FadeIn();
  }

  static Effect fadeOut([FadeOut? fadeOut]) {
    return fadeOut ?? FadeOut();
  }

  static Effect loop([Loop? loop]) {
    return loop ?? Loop();
  }

  static Effect blackwhite([Blackwhite? blackWhite]) {
    return blackWhite ?? Blackwhite();
  }

  static Effect dither([Dither? dither]) {
    return dither ?? Dither();
  }

  static Effect vignette([Vignette? vignette]) {
    return vignette ?? Vignette();
  }

  static Effect simulateColorBlind([SimulateColorBlind? simulateColorBlind]) {
    return simulateColorBlind ?? SimulateColorBlind();
  }

  static Effect cartoonify([Cartoonify? cartoonify]) {
    return cartoonify ?? Cartoonify();
  }

  static Effect shadow([Shadow? shadow]) {
    return shadow ?? Shadow();
  }

  static Effect vectorize([Vectorize? vectorize]) {
    return vectorize ?? Vectorize();
  }

  static Effect outline([Outline? outline]) {
    return outline ?? Outline();
  }

  static Effect artisticFilter(ArtisticFilter filter) {
    return Artistic(filter);
  }

  static Effect negate([Negate? negate]) {
    return negate ?? Negate();
  }

  static Effect redEye([RedEye? redEye]) {
    return redEye ?? RedEye();
  }

  static Effect grayscale([Grayscale? grayscale]) {
    return grayscale ?? Grayscale();
  }

  static oilPaint([OilPaint? oilPaint]) {
    return oilPaint ?? OilPaint();
  }

  static advancedRedEye([AdvancedRedEye? advancedRedEye]) {
    return advancedRedEye ?? AdvancedRedEye();
  }

  static pixelate([Pixelate? pixelate]) {
    return pixelate ?? Pixelate();
  }

  static blur([Blur? blur]) {
    return blur ?? Blur();
  }

  static colorize([Colorize? colorize]) {
    return colorize ?? Colorize();
  }

  static gradientFade([GradientFade? gradientFade]) {
    return gradientFade ?? GradientFade();
  }

  static assistColorBlind([AssistColorBlind? assistColorBlind]) {
    return assistColorBlind ?? AssistColorBlind();
  }

  static theme(Theme theme) {
    return theme;
  }

  @override
  String toString() {
    return 'e';
  }
}
