import 'package:cloudinary_dart/transformation/adjust/adjust.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful opacity formatting', () {
    cldAssert("o_30", Adjust.opacity(30));
    cldAssert("o_30", Adjust.opacity() ..level(30));
  });
  test('Test successful tint formatting', () {
    cldAssert("e_tint:50:red:blue", Adjust.tint("50:red:blue"));
  });
  test('Test successful vibrance formatting', () {
    cldAssert("e_vibrance", Adjust.vibrance());
    cldAssert("e_vibrance:70", Adjust.vibrance(70));
    cldAssert("e_vibrance:70", Adjust.vibrance() ..strength(70));
  });
  test('Test successful auto color formatting', () {
    cldAssert("e_auto_color", Adjust.autoColor());
    cldAssert("e_auto_color:80", Adjust.autoColor(80));
    cldAssert("e_auto_color:80", Adjust.autoColor() ..blend(80));
  });
  test('Test successful brightness formatting', ()  {
    cldAssert("e_brightness", Adjust.brightness());
    cldAssert("e_brightness:70", Adjust.brightness(70));
    cldAssert("e_brightness:70", Adjust.brightness() ..level(70));
  });
}