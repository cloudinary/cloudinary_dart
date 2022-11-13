import 'package:cloudinary_dart/transformation/rotate.dart';
import 'package:cloudinary_dart/transformation/transformation.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful rotate formatting', () {
    assert('a_50' == (Transformation() ..rotate(Rotate.byAngle(50))).toString());
    assert('a_50' == (Transformation() ..rotate(Rotate(50))).toString());
    cldAssert("a_-50", Transformation().rotate(Rotate.byAngle(-50)));
    cldAssert("a_hflip", Transformation().rotate(Rotate.mode(RotationMode.horizontalFlip())));
  });
}