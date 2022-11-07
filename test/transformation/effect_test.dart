import 'package:cloudinary_dart/src/transformation/effect/effect.dart';
import 'package:cloudinary_dart/src/transformation/effect/effect_actions.dart';
import 'package:test/test.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful sepia effect formatting', () {
    cldAssert('e_sepia', Effect.sepia());
    cldAssert("e_sepia:50", Effect.sepia(Sepia(50)));
  });
}