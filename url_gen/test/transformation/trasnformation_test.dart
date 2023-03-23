import 'package:test/scaffolding.dart';

import '../../lib/transformation/adjust/adjust.dart';
import '../../lib/transformation/delivery/delivery.dart';
import '../../lib/transformation/delivery/delivery_actions.dart';
import '../../lib/transformation/effect/effect.dart';
import '../../lib/transformation/named_transformation.dart';
import '../../lib/transformation/resize/resize.dart';
import '../../lib/transformation/rotate.dart';
import '../../lib/transformation/transformation.dart';
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
  test('Test successful named transformation formatting', () {
    cldAssert("t_named", Transformation().namedTransformation('named'));
    cldAssert(
        "t_named",
        Transformation()
            .namedTransformation(NamedTransformation.name("named")));
  });
}
