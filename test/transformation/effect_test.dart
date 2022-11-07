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
    cldAssert("e_deshake:16", Effect.deshake(Deshake(ShakeStrength.pixels16())));
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
    cldAssert("e_make_transparent:50", Effect.makeTransparent(MakeTransparent(tolerance: 50)));
    cldAssert("e_make_transparent:50", Effect.makeTransparent(MakeTransparent() ..tolerance(50)));
  });
}