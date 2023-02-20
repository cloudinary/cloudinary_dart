import 'package:test/scaffolding.dart';

import '../../lib/transformation/background/background.dart';
import '../../lib/transformation/background/border_background.dart';
import '../../lib/transformation/color.dart';
import '../../lib/transformation/gravity/focus_on.dart';
import '../../lib/transformation/gravity/gravity.dart';
import '../../lib/transformation/resize/resize.dart';
import '../tests_utils.dart';

void main() {
  test('Test successful scale formatting', () {
    cldAssert("c_scale,w_100", Resize.scale()..width(100));
    cldAssert("c_scale,w_1.0", Resize.scale()..width(1.0));
    cldAssert(
        "c_scale,h_100,w_100",
        Resize.scale()
          ..width(100)
          ..height(100));
    cldAssert(
        "c_scale,h_1.1,w_0.5",
        Resize.scale()
          ..width(0.5)
          ..height(1.1));
    cldAssert(
        "ar_1.5,c_scale,w_100",
        Resize.scale()
          ..width(100)
          ..aspectRatio(1.5));
    cldAssert(
        "ar_1.5,c_scale,h_100",
        Resize.scale()
          ..height(100)
          ..aspectRatio(1.5));
    cldAssert(
        "c_scale,w_100",
        Resize.scale()
          ..width(100)
          ..liquidRescaling(false));
    cldAssert(
        "c_scale,g_liquid,w_100",
        Resize.scale()
          ..width(100)
          ..liquidRescaling(true));
  });

  test('Test successful fit formatting', () {
    cldAssert("c_fit,w_100", Resize.fit()..width(100));
    cldAssert(
        "c_fit,h_100,w_100",
        Resize.fit()
          ..width(100)
          ..height(100));
    cldAssert(
        "c_fit,h_1.1,w_0.5",
        Resize.fit()
          ..width(0.5)
          ..height(1.1));
    cldAssert(
        "ar_1.5,c_fit,w_100",
        Resize.fit()
          ..width(100)
          ..aspectRatio(1.5));
    cldAssert(
        "ar_1.5,c_fit,h_100",
        Resize.fit()
          ..height(100)
          ..aspectRatio(1.5));
  });

  test('Test successful limit fit formatting', () {
    cldAssert('c_limit,w_100', Resize.limitFit()..width(100));
    cldAssert('c_limit,w_1.0', Resize.limitFit()..width(1.0));
    cldAssert(
        'c_limit,h_100,w_100',
        Resize.limitFit()
          ..width(100)
          ..height(100));
    cldAssert(
        'c_limit,h_1.1,w_0.5',
        Resize.limitFit()
          ..width(0.5)
          ..height(1.1));
    cldAssert(
        'ar_1.5,c_limit,w_100',
        Resize.limitFit()
          ..width(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_limit,h_100',
        Resize.limitFit()
          ..height(100)
          ..aspectRatio(1.5));
  });

  test('Test successful minimum fit formatting', () {
    cldAssert('c_mfit,w_100', Resize.minimumFit()..width(100));
    cldAssert('c_mfit,w_1.0', Resize.minimumFit()..width(1.0));
    cldAssert(
        'c_mfit,h_100,w_100',
        Resize.minimumFit()
          ..width(100)
          ..height(100));
    cldAssert(
        'c_mfit,h_1.1,w_0.5',
        Resize.minimumFit()
          ..width(0.5)
          ..height(1.1));
    cldAssert(
        'ar_1.5,c_mfit,w_100',
        Resize.minimumFit()
          ..width(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_mfit,h_100',
        Resize.minimumFit()
          ..height(100)
          ..aspectRatio(1.5));
  });

  test("Test successful crop formatting", () {
    cldAssert('c_crop,w_100', Resize.crop()..width(100));
    cldAssert('c_crop,w_1.0', Resize.crop()..width(1.0));
    cldAssert(
        'c_crop,h_100,w_100',
        Resize.crop()
          ..width(100)
          ..height(100));
    cldAssert(
        'c_crop,h_1.1,w_0.5',
        Resize.crop()
          ..width(0.5)
          ..height(1.1));
    cldAssert(
        'ar_1.5,c_crop,w_100',
        Resize.crop()
          ..width(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_crop,h_100',
        Resize.crop()
          ..height(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_crop,g_north,h_100',
        Resize.crop()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north()));
    cldAssert(
        'ar_1.5,c_crop,g_north,h_100,z_1.5',
        Resize.crop()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())
          ..zoom(1.5));
    cldAssert(
        'ar_1.5,c_crop,g_face,h_100',
        Resize.crop()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.focusOn([FocusOn.face()])));
  });

  test("Test successful thumbnail formatting", () {
    cldAssert('c_thumb,w_100', Resize.thumbnail()..width(100));

    cldAssert(
        'ar_1.5,c_thumb,g_north,h_100,z_1.5',
        Resize.thumbnail()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())
          ..zoom(1.5));
  });

  test('Test successful pad formatting', () {
    cldAssert('c_pad,w_1.0', Resize.pad()..width(1.0));
    cldAssert(
        'c_pad,h_100,w_100',
        Resize.pad()
          ..width(100)
          ..height(100));
    cldAssert(
        'c_pad,h_1.1,w_0.5',
        Resize.pad()
          ..width(0.5)
          ..height(1.1));
    cldAssert(
        'ar_1.5,c_pad,w_100',
        Resize.pad()
          ..width(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_pad,h_100',
        Resize.pad()
          ..height(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_pad,g_north,h_100',
        Resize.pad()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north()));
    cldAssert(
        'ar_1.5,b_black,c_pad,h_100',
        Resize.pad()
          ..height(100)
          ..aspectRatio(1.5)
          ..background(Background.color(Color.black())));
    cldAssert(
        'ar_1.5,b_auto:predominant,c_pad,h_100',
        Resize.pad()
          ..height(100)
          ..aspectRatio(1.5)
          ..background(Background.predominant()));
    cldAssert(
        'ar_1.5,b_auto:border_contrast,c_pad,h_100',
        Resize.pad()
          ..height(100)
          ..aspectRatio(1.5)
          ..background(Background.border(BorderBackground()..contrast())));
  });

  test('Test successful limit pad formatting', () {
    cldAssert('c_lpad,w_100', Resize.limitPad()..width(100));
    cldAssert('c_lpad,w_1.0', Resize.limitPad()..width(1.0));
    cldAssert(
        'c_lpad,h_100,w_100',
        Resize.limitPad()
          ..width(100)
          ..height(100));
    cldAssert(
        'c_lpad,h_1.1,w_0.5',
        Resize.limitPad()
          ..width(0.5)
          ..height(1.1));
    cldAssert(
        'ar_1.5,c_lpad,w_100',
        Resize.limitPad()
          ..width(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_lpad,h_100',
        Resize.limitPad()
          ..height(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_lpad,g_north,h_100',
        Resize.limitPad()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north()));
  });

  test('Test successful minimum pad formatting', () {
    cldAssert('c_mpad,w_100', Resize.minimumPad()..width(100));
    cldAssert('c_mpad,w_1.0', Resize.minimumPad()..width(1.0));
    cldAssert(
        'c_mpad,h_100,w_100',
        Resize.minimumPad()
          ..width(100)
          ..height(100));
    cldAssert(
        'c_mpad,h_1.1,w_0.5',
        Resize.minimumPad()
          ..width(0.5)
          ..height(1.1));
    cldAssert(
        'ar_1.5,c_mpad,w_100',
        Resize.minimumPad()
          ..width(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_mpad,h_100',
        Resize.minimumPad()
          ..height(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_mpad,g_north,h_100',
        Resize.minimumPad()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north()));
  });

  test("Test successful fill formatting", () {
    cldAssert('c_fill,w_100', Resize.fill()..width(100));
    cldAssert('c_fill,w_1.0', Resize.fill()..width(1.0));
    cldAssert(
        'c_fill,h_100,w_100',
        Resize.fill()
          ..width(100)
          ..height(100));
    cldAssert(
        'c_fill,h_1.1,w_0.5',
        Resize.fill()
          ..width(0.5)
          ..height(1.1));
    cldAssert(
        'ar_1.5,c_fill,w_100',
        Resize.fill()
          ..width(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_fill,h_100',
        Resize.fill()
          ..height(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_fill,g_north,h_100',
        Resize.fill()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north()));
    cldAssert(
        'c_fill,g_xy_center,x_100,y_100',
        Resize.fill()
          ..gravity(Gravity.xyCenter())
          ..x(100)
          ..y(100));
  });

  test("Test successful limit fill formatting", () {
    cldAssert('c_lfill,w_100', Resize.limitFill()..width(100));
    cldAssert('c_lfill,w_1.0', Resize.limitFill()..width(1.0));
    cldAssert(
        'c_lfill,h_100,w_100',
        Resize.limitFill()
          ..width(100)
          ..height(100));
    cldAssert(
        'c_lfill,h_1.1,w_0.5',
        Resize.limitFill()
          ..width(0.5)
          ..height(1.1));
    cldAssert(
        'ar_1.5,c_lfill,w_100',
        Resize.limitFill()
          ..width(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_lfill,h_100',
        Resize.limitFill()
          ..height(100)
          ..aspectRatio(1.5));
    cldAssert(
        'ar_1.5,c_lfill,g_north,h_100',
        Resize.limitFill()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north()));
    cldAssert(
        'c_lfill,g_xy_center,x_100,y_100',
        Resize.limitFill()
          ..gravity(Gravity.xyCenter())
          ..x(100)
          ..y(100));
  });
}
