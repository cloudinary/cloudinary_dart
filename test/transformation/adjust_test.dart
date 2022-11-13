import 'package:cloudinary_dart/transformation/adjust/adjust.dart';
import 'package:cloudinary_dart/transformation/adjust/adjust_actions.dart';
import 'package:cloudinary_dart/transformation/color.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful opacity formatting', () {
    cldAssert("o_30", Adjust.opacity(30));
    cldAssert("o_30", Adjust.opacity()..level(30));
  });
  test('Test successful tint formatting', () {
    cldAssert("e_tint:50:red:blue", Adjust.tint("50:red:blue"));
  });
  test('Test successful vibrance formatting', () {
    cldAssert("e_vibrance", Adjust.vibrance());
    cldAssert("e_vibrance:70", Adjust.vibrance(70));
    cldAssert("e_vibrance:70", Adjust.vibrance()..strength(70));
  });
  test('Test successful auto color formatting', () {
    cldAssert("e_auto_color", Adjust.autoColor());
    cldAssert("e_auto_color:80", Adjust.autoColor(80));
    cldAssert("e_auto_color:80", Adjust.autoColor()..blend(80));
  });
  test('Test successful brightness formatting', () {
    cldAssert("e_brightness", Adjust.brightness());
    cldAssert("e_brightness:70", Adjust.brightness(70));
    cldAssert("e_brightness:70", Adjust.brightness()..level(70));
  });
  test('Test successful auto brightness formatting', () {
    cldAssert("e_auto_brightness", Adjust.autoBrightness());
    cldAssert("e_auto_brightness:70", Adjust.autoBrightness()..blend(70));
    cldAssert("e_auto_brightness:70", Adjust.autoBrightness(70));
  });
  test('Test successful brightness HSB formatting', () {
    cldAssert("e_brightness_hsb", Adjust.brightnessHSB());
    cldAssert("e_brightness_hsb:70", Adjust.brightnessHSB()..level(70));
    cldAssert("e_brightness_hsb:70", Adjust.brightnessHSB(70));
  });
  test('Test successful auto contrast formatting', () {
    cldAssert("e_auto_contrast", Adjust.autoContrast());
    cldAssert("e_auto_contrast:50", Adjust.autoContrast()..blend(50));
    cldAssert("e_auto_contrast:50", Adjust.autoContrast(50));
  });
  test('Test successful unsharp mask formatting', () {
    cldAssert("e_unsharp_mask", Adjust.unsharpMask());
    cldAssert("e_unsharp_mask:200", Adjust.unsharpMask()..strength(200));
    cldAssert("e_unsharp_mask:200", Adjust.unsharpMask(200));
  });
  test('Test successful viesus correct formatting', () {
    cldAssert("e_viesus_correct", Adjust.viesusCorrect());
    cldAssert("e_viesus_correct:skin_saturation",
        Adjust.viesusCorrect()..skinSaturation());
    cldAssert("e_viesus_correct:skin_saturation_20",
        Adjust.viesusCorrect()..skinSaturation(20));
    cldAssert(
        "e_viesus_correct:no_redeye:skin_saturation_20",
        Adjust.viesusCorrect()
          ..skinSaturation(20)
          ..noRedEye());
    cldAssert("e_viesus_correct:no_redeye", Adjust.viesusCorrect()..noRedEye());
  });
  test('Test successful hue formatting', () {
    cldAssert("e_hue", Adjust.hue());
    cldAssert("e_hue:40", Adjust.hue()..level(40));
    cldAssert("e_hue:40", Adjust.hue(40));
  });
  test('Test successful gamma formatting', () {
    cldAssert("e_gamma", Adjust.gamma());
    cldAssert("e_gamma:50", Adjust.gamma()..level(50));
    cldAssert("e_gamma:50", Adjust.gamma(50));
  });
  test('Test successful contrast formatting', () {
    cldAssert("e_contrast", Adjust.contrast());
    cldAssert("e_contrast:70", Adjust.contrast()..level(70));
    cldAssert("e_contrast:70", Adjust.contrast(70));
  });
  test('Test successful green formatting', () {
    cldAssert("e_green", Adjust.green());
    cldAssert("e_green:-30", Adjust.green()..level(-30));
    cldAssert("e_green:-30", Adjust.green(-30));
  });

  test('Test successful blue formatting', () {
    cldAssert("e_blue", Adjust.blue());
    cldAssert("e_blue:90", Adjust.blue()..level(90));
    cldAssert("e_blue:90", Adjust.blue(90));
  });

  test('Test successful red formatting', () {
    cldAssert("e_red", Adjust.red());
    cldAssert("e_red:50", Adjust.red()..level(50));
    cldAssert("e_red:50", Adjust.red(50));
  });
  test('Test successful opacity threshold formatting', () {
    cldAssert("e_opacity_threshold", Adjust.opacityThreshold());
    cldAssert("e_opacity_threshold:100", Adjust.opacityThreshold()..level(100));
    cldAssert("e_opacity_threshold:100", Adjust.opacityThreshold(100));
  });
  test('Test successful saturation formatting', () {
    cldAssert("e_saturation", Adjust.saturation());
    cldAssert("e_saturation:70", Adjust.saturation()..level(70));
    cldAssert("e_saturation:70", Adjust.saturation(70));
  });
  test('Test successful sharpen formatting', () {
    cldAssert("e_sharpen", Adjust.sharpen());
    cldAssert("e_sharpen:400", Adjust.sharpen()..strength(400));
    cldAssert("e_sharpen:400", Adjust.sharpen(400));
  });
  test('Test successful replace color formatting', () {
    cldAssert("e_replace_color:saddlebrown",
        Adjust.replaceColor(Color.saddlebrown()));
    cldAssert("e_replace_color:2F4F4F:20",
        Adjust.replaceColor(Color.rgb("2F4F4F"))..tolerance(20));
    cldAssert(
        "e_replace_color:silver:50:89b8ed",
        Adjust.replaceColor(Color.silver())
          ..tolerance(50)
          ..fromColor(Color.rgb("#89b8ed")));
  });
  test('Test successful recolor formatting', () {
    cldAssert(
        "e_recolor:0.1:0.2:0.3:0.4:0.5:0.6:0.7:0.8:0.9",
        Adjust.recolor([
          [0.1, 0.2, 0.3],
          [0.4, 0.5, 0.6],
          [0.7, 0.8, 0.9]
        ]));
  });
  test('Test successful fill light formatting', () {
    cldAssert("e_fill_light", Adjust.fillLight());
    cldAssert("e_fill_light:70", Adjust.fillLight()..bias(70));
    cldAssert(
        "e_fill_light:70:20",
        Adjust.fillLight()
          ..bias(20)
          ..blend(70));
    cldAssert("e_fill_light:70:20", Adjust.fillLight(blend: 70, bias: 20));
  });
  test('Test successful improve formatting', () {
    cldAssert("e_improve", Adjust.improve());

    cldAssert("e_improve:50", Adjust.improve()..blend(50));
    cldAssert("e_improve:50", Adjust.improve(blend: 50));

    cldAssert("e_improve:indoor", Adjust.improve()..mode(ImproveMode.indoor()));

    cldAssert(
        "e_improve:outdoor:30",
        Adjust.improve()
          ..blend(30)
          ..mode(ImproveMode.outdoor()));
    cldAssert("e_improve:outdoor:30",
        Adjust.improve(blend: 30, mode: ImproveMode.outdoor()));
  });
  test('Test successful by 3d lut formatting', () {
    cldAssert("l_lut:iwltbap_aspen.3dl", Adjust.by3dLut("iwltbap_aspen.3dl"));
  });
}
