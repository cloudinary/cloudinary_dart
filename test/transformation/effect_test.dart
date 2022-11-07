import 'package:cloudinary_dart/src/transformation/effect/effect.dart';
import 'package:cloudinary_dart/src/transformation/effect/effect_actions.dart';
import 'package:test/test.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful sepia effect formatting', () {
    cldAssert('e_sepia', Effect.sepia());
    cldAssert("e_sepia:50", Effect.sepia(Sepia(50)));
  });

  test('Test successful accelerate effect formatting', () {
    cldAssert("e_accelerate", Effect.accelerate());
    cldAssert("e_accelerate:100", Effect.accelerate(Accelerate(100)));
  });

  test('Test successful deshake effect formatting', () {
    cldAssert("e_deshake", Effect.deshake());
    cldAssert(
        "e_deshake:16", Effect.deshake(Deshake(ShakeStrength.pixels16())));
  });

  test('Test successful reverse effect formatting', () {
    cldAssert("e_reverse", Effect.reverse());
  });

  test('Test successful boomerang effect formatting', () {
    cldAssert("e_boomerang", Effect.boomerang());
  });
  test('Test successful noise effect formatting', () {
    cldAssert("e_noise", Effect.noise());
    cldAssert("e_noise:10", Effect.noise(Noise(10)));
  });
  test('Test successful make transparent effect formatting', () {
    cldAssert("e_make_transparent", Effect.makeTransparent());
    cldAssert("e_make_transparent:50",
        Effect.makeTransparent(MakeTransparent(tolerance: 50)));
    cldAssert("e_make_transparent:50",
        Effect.makeTransparent(MakeTransparent()..tolerance(50)));
  });
  test('Test successful fade in effect formatting', () {
    cldAssert("e_fade", Effect.fadeIn());
    cldAssert("e_fade:2000", Effect.fadeIn(FadeIn(2000)));
    cldAssert("e_fade:-2000", Effect.fadeOut(FadeOut(2000)));
  });
  test('Test successful loop in effect formatting', () {
    cldAssert("e_loop", Effect.loop());
    cldAssert("e_loop:2", Effect.loop(Loop(2)));
    cldAssert("e_loop:2", Effect.loop(Loop()..additionalIterations(2)));
  });
  test('Test successful black white effect formatting', () {
    cldAssert("e_blackwhite", Effect.blackwhite());
    cldAssert("e_blackwhite:50", Effect.blackwhite(Blackwhite(50)));
    cldAssert(
        "e_blackwhite:50", Effect.blackwhite(Blackwhite()..threshold(50)));
  });
  test('Test successful dither effect formatting', () {
    cldAssert("e_ordered_dither:0",
        Effect.dither(Dither(DitherObject.threshold1x1NonDither())));
  });
}
