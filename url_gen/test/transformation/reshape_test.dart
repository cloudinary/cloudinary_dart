import 'package:cloudinary_dart/transformation/color.dart';
import 'package:cloudinary_dart/transformation/reshape/reshape.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful reshape shear formatting', () {
    cldAssert("e_shear:20:0", Reshape.shear(20, 0));
    cldAssert("e_shear:20:0", Reshape.shear().skewX(20).skewY(0));
  });
  test('Test successful reshape distort formatting', () {
    cldAssert(
        "e_distort:5:34:70:10:70:75:5:55",
        Reshape.distort([5, 34, 70, 10, 70, 75, 5, 55]));
  });
  test('Test successful reshape distort arc formatting', () {
    cldAssert("e_distort:arc:180", Reshape.distortArc(180));
  });
  test('Test successful reshape trim formatting', () {
    cldAssert("e_trim", Reshape.trim());
    cldAssert("e_trim:30", Reshape.trim().colorSimilarity(30));
    cldAssert("e_trim:white", Reshape.trim().colorOverride(Color.white()));
    cldAssert(
        "e_trim:30:white",
        Reshape.trim().colorSimilarity(30).colorOverride(Color.white()));
  });
}