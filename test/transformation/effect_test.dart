import 'package:cloudinary_dart/src/transformation/color.dart';
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
  test('Test successful vignette effect formatting', () {
    cldAssert("e_vignette", Effect.vignette());
    cldAssert("e_vignette:30", Effect.vignette(Vignette(30)));
    cldAssert("e_vignette:30", Effect.vignette(Vignette()..strength(30)));
  });
  test('Test successful simulate blind effect formatting', () {
    cldAssert("e_simulate_colorblind", Effect.simulateColorBlind());
    cldAssert(
        "e_simulate_colorblind:deuteranopia",
        Effect.simulateColorBlind(
            SimulateColorBlind(SimulateColorBlindObject.deuteranopia())));
  });
  test('Test successful cartoonify effect formatting', () {
    cldAssert("e_cartoonify", Effect.cartoonify());
    cldAssert(
        "e_cartoonify:20", Effect.cartoonify(Cartoonify(lineStrength: 20)));
    cldAssert(
        "e_cartoonify:20:60",
        Effect.cartoonify(Cartoonify()
          ..lineStrength(20)
          ..colorReductionLevel(60)));
    cldAssert("e_cartoonify:30:bw",
        Effect.cartoonify(Cartoonify(lineStrength: 30, blackwhite: true)));
    cldAssert(
        "e_cartoonify:30:bw",
        Effect.cartoonify(Cartoonify()
          ..lineStrength(30)
          ..colorReductionLevel(60)
          ..blackwhite()));
    cldAssert(
        "e_cartoonify:bw",
        Effect.cartoonify(Cartoonify()
          ..colorReductionLevel(60)
          ..blackwhite()));
  });
  test('Test successful shadow effect formatting', () {
    cldAssert("e_shadow", Effect.shadow());
    cldAssert("e_shadow:50", Effect.shadow(Shadow(strength: 50)));
    cldAssert("e_shadow:50", Effect.shadow(Shadow()..strength(50)));
    cldAssert(
        "co_green,e_shadow:50",
        Effect.shadow(Shadow()
          ..strength(50)
          ..color(Color.green())));
    cldAssert(
        "co_green,e_shadow:50,x_20,y_-20",
        Effect.shadow(Shadow()
          ..strength(50)
          ..color(Color.green())
          ..offsetX(20)
          ..offsetY(-20)));
  });
}
