import 'package:cloudinary_dart/transformation/round_corners.dart';
import 'package:cloudinary_dart/transformation/transformation.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful round corners formatting', () {
    cldAssert("r_20", Transformation().roundCorners(20));
    cldAssert("r_20:30", Transformation().roundCorners([20, 30]));
    cldAssert("r_20:30", Transformation().roundCorners(RoundCorners.byRadius([20, 30])));
    cldAssert("r_20:30:40", Transformation().roundCorners([20, 30, 40]));
    cldAssert("r_20:30:40:50", Transformation().roundCorners([20, 30, 40, 50]));
    cldAssert("r_max", Transformation().roundCorners(RoundCorners.max()));
    // cldAssert("r_w_mul_2", Transformation().roundCorners(RoundCorners.byRadius(Expression("width * 2"))));
  });
}
