import 'package:cloudinary_dart/transformation/border.dart';
import 'package:cloudinary_dart/transformation/color.dart';
import 'package:cloudinary_dart/transformation/round_corners.dart';
import 'package:cloudinary_dart/transformation/transformation.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful border formatting', () {
    cldAssert("bo_3px_solid_rgb:00390b",
        Transformation().border(Border.solid(3, Color.rgb("00390b"))));
  });

  test('Test successful border with round corners formatting', () {
    cldAssert(
        "bo_4px_solid_black,r_20:30",
        Transformation().border(Border.solid(4, Color.black())
            .roundCorners(RoundCorners([20, 30]))));

    cldAssert(
        "bo_4px_solid_black,r_max",
        Transformation().border(
            Border.solid(4, Color.black()).roundCorners(RoundCorners.max())));
  });
}
