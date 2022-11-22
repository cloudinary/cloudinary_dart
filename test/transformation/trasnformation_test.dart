import 'package:cloudinary_dart/transformation/adjust/adjust.dart';
import 'package:cloudinary_dart/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_dart/transformation/effect/effect.dart';
import 'package:cloudinary_dart/transformation/named_transformation.dart';
import 'package:cloudinary_dart/transformation/resize/resize.dart';
import 'package:cloudinary_dart/transformation/rotate.dart';
import 'package:cloudinary_dart/transformation/transformation.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful rotate formatting', () {
    cldAssert('a_50', (Transformation()..rotate(Rotate.byAngle(50))));
    cldAssert('a_50', (Transformation()..rotate(Rotate(50))));
    cldAssert("a_-50", Transformation().rotate(Rotate.byAngle(-50)));
    cldAssert("a_hflip",
        Transformation().rotate(Rotate.mode(RotationMode.horizontalFlip())));
  });
  test('Test successful resize transformation formatting', () {
    cldAssert(
        'c_scale,w_500', Transformation()..resize(Resize.scale()..width(500)));
  });
  test('Test successful delivery transformation formatting', () {
    cldAssert('q_auto', Transformation()..delivery(Quality(Quality.auto)));
  });
  test('Test successful effect transformation formatting', () {
    cldAssert('e_sepia:50', Transformation()..effect(Effect.sepia(50)));
  });
  test('Test successful adjust transformation formatting', () {
    cldAssert('e_hue:30', Transformation()..adjust(Adjust.hue(30)));
  });
  test('Test successful generic transformation formatting', () {
    cldAssert('a_0', Transformation()..generic('a_0'));
  });
  test('Test successful named transformation formatting', () {
    cldAssert("t_named", Transformation().namedTransformation('named'));
    cldAssert(
        "t_named",
        Transformation()
            .namedTransformation(NamedTransformation.name("named")));
  });
}
