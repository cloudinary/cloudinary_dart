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
  test('Test successful auto brightness formatting', () {
    cldAssert("e_auto_brightness", Adjust.autoBrightness());
    cldAssert("e_auto_brightness:70", Adjust.autoBrightness() ..blend(70));
    cldAssert("e_auto_brightness:70", Adjust.autoBrightness(70));
  });
  test('Test successful brightness HSB formatting', () {
    cldAssert("e_brightness_hsb", Adjust.brightnessHSB());
    cldAssert("e_brightness_hsb:70", Adjust.brightnessHSB()
      ..level(70));
    cldAssert("e_brightness_hsb:70", Adjust.brightnessHSB(70));
  });
  test('Test successful auto contrast formatting', () {
    cldAssert("e_auto_contrast", Adjust.autoContrast());
    cldAssert("e_auto_contrast:50", Adjust.autoContrast() ..blend(50));
    cldAssert("e_auto_contrast:50", Adjust.autoContrast(50));
  });
  test('Test successful unsharp mask formatting', () {
    cldAssert("e_unsharp_mask", Adjust.unsharpMask());
    cldAssert("e_unsharp_mask:200", Adjust.unsharpMask() ..strength(200));
    cldAssert("e_unsharp_mask:200", Adjust.unsharpMask(200));
  });
  test('Test successful viesus correct formatting', () {
    cldAssert("e_viesus_correct", Adjust.viesusCorrect());
    cldAssert("e_viesus_correct:skin_saturation", Adjust.viesusCorrect() ..skinSaturation());
    cldAssert("e_viesus_correct:skin_saturation_20", Adjust.viesusCorrect() ..skinSaturation(20));
    cldAssert("e_viesus_correct:no_redeye:skin_saturation_20", Adjust.viesusCorrect() ..skinSaturation(20) ..noRedEye());
    cldAssert("e_viesus_correct:no_redeye", Adjust.viesusCorrect() ..noRedEye());
  });

}