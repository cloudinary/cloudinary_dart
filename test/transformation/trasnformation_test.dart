import 'package:cloudinary_dart/transformation/delivery/delivery_actions.dart';
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
    cldAssert('c_scale,w_500', Transformation() ..resize(Resize.scale() ..width(500)));
  });
  test('Test successful delivery transformation formatting', () {
    cldAssert('q_auto', Transformation() ..delivery(Quality(Quality.auto)));
  });
  test('Test successful effect transformation formatting', () {
    // cldAssert('q_auto', Transformation() ..);
  });
}
