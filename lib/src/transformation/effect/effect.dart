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

  @override
  String toString() {
    return 'e';
  }
}
