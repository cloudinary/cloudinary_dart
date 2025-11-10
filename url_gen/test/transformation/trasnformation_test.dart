import 'package:cloudinary_url_gen/cloudinary.dart'
    show RotationMode, Effect, Resize, Adjust, NamedTransformation;
import 'package:cloudinary_url_gen/src/transformation/delivery/delivery.dart'
    show Delivery;
import 'package:cloudinary_url_gen/src/transformation/delivery/delivery_actions.dart'
    show Quality;
import 'package:cloudinary_url_gen/src/transformation/rotate.dart' show Rotate;
import 'package:cloudinary_url_gen/src/transformation/transformation.dart'
    show Transformation;
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
    cldAssert(
        'q_auto', Transformation()..delivery(Delivery.quality(Quality.auto())));
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
  test('Test successful add transformations formatting', () {
    cldAssert('a_0', Transformation()..addTransformation('a_0'));
  });
  test('Test successful named transformation formatting', () {
    cldAssert("t_named", Transformation().namedTransformation('named'));
    cldAssert(
        "t_named",
        Transformation()
            .namedTransformation(NamedTransformation.name("named")));
  });
}
