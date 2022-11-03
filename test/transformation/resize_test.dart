import 'package:cloudinary_dart/src/transformation/background/background.dart';
import 'package:cloudinary_dart/src/transformation/background/border_background.dart';
import 'package:cloudinary_dart/src/transformation/color.dart';
import 'package:cloudinary_dart/src/transformation/gravity/gravity.dart';
import 'package:cloudinary_dart/src/transformation/resize/crop.dart';
import 'package:cloudinary_dart/src/transformation/resize/fit.dart';
import 'package:cloudinary_dart/src/transformation/resize/pad.dart';
import 'package:cloudinary_dart/src/transformation/resize/resize.dart';
import 'package:cloudinary_dart/src/transformation/resize/scale.dart';
import 'package:test/test.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful scale formatting', () {
    cldAssert("c_scale,w_100", Resize.scale(Scale()..width(100)));
    cldAssert("c_scale,w_1.0", Resize.scale(Scale()..width(1.0)));
    cldAssert(
        "c_scale,h_100,w_100",
        Resize.scale(Scale()
          ..width(100)
          ..height(100)));
    cldAssert(
        "c_scale,h_1.1,w_0.5",
        Resize.scale(Scale()
          ..width(0.5)
          ..height(1.1)));
    cldAssert(
        "ar_1.5,c_scale,w_100",
        Resize.scale(Scale()
          ..width(100)
          ..aspectRatio(1.5)));
    cldAssert(
        "ar_1.5,c_scale,h_100",
        Resize.scale(Scale()
          ..height(100)
          ..aspectRatio(1.5)));
    cldAssert(
        "c_scale,w_100",
        Resize.scale(Scale()
          ..width(100)
          ..liquidRescaling(false)));
    cldAssert(
        "c_scale,g_liquid,w_100",
        Resize.scale(Scale()
          ..width(100)
          ..liquidRescaling(true)));
  });

  test('Test successful fit formatting', () {
    print(Resize.fit(Fit()..width(100)));
    cldAssert("c_fit,w_100", Resize.fit(Fit()..width(100)));
    cldAssert(
        "c_fit,h_100,w_100",
        Resize.fit(Fit()
          ..width(100)
          ..height(100)));
    cldAssert(
        "c_fit,h_1.1,w_0.5",
        Resize.fit(Fit()
          ..width(0.5)
          ..height(1.1)));
    cldAssert(
        "ar_1.5,c_fit,w_100",
        Resize.fit(Fit()
          ..width(100)
          ..aspectRatio(1.5)));
    cldAssert(
        "ar_1.5,c_fit,h_100",
        Resize.fit(Fit()
          ..height(100)
          ..aspectRatio(1.5)));
  });

  test('Test successful limit fit formatting', () {
    cldAssert('c_limit,w_100', Resize.limitFit(LimitFit()..width(100)));
    cldAssert('c_limit,w_1.0', Resize.limitFit(LimitFit()..width(1.0)));
    cldAssert(
        'c_limit,h_100,w_100',
        Resize.limitFit(LimitFit()
          ..width(100)
          ..height(100)));
    cldAssert(
        'c_limit,h_1.1,w_0.5',
        Resize.limitFit(LimitFit()
          ..width(0.5)
          ..height(1.1)));
    cldAssert(
        'ar_1.5,c_limit,w_100',
        Resize.limitFit(LimitFit()
          ..width(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_limit,h_100',
        Resize.limitFit(LimitFit()
          ..height(100)
          ..aspectRatio(1.5)));
  });

  test('Test successful minimum fit formatting', () {
    cldAssert('c_mfit,w_100', Resize.minimumFit(MinimumFit()..width(100)));
    cldAssert('c_mfit,w_1.0', Resize.minimumFit(MinimumFit()..width(1.0)));
    cldAssert(
        'c_mfit,h_100,w_100',
        Resize.minimumFit(MinimumFit()
          ..width(100)
          ..height(100)));
    cldAssert(
        'c_mfit,h_1.1,w_0.5',
        Resize.minimumFit(MinimumFit()
          ..width(0.5)
          ..height(1.1)));
    cldAssert(
        'ar_1.5,c_mfit,w_100',
        Resize.minimumFit(MinimumFit()
          ..width(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_mfit,h_100',
        Resize.minimumFit(MinimumFit()
          ..height(100)
          ..aspectRatio(1.5)));
  });

  test("Test successful crop formatting", () {
    cldAssert('c_crop,w_100', Resize.crop(Crop()..width(100)));
    cldAssert('c_crop,w_1.0', Resize.crop(Crop()..width(1.0)));
    cldAssert(
        'c_crop,h_100,w_100',
        Resize.crop(Crop()
          ..width(100)
          ..height(100)));
    cldAssert(
        'c_crop,h_1.1,w_0.5',
        Resize.crop(Crop()
          ..width(0.5)
          ..height(1.1)));
    cldAssert(
        'ar_1.5,c_crop,w_100',
        Resize.crop(Crop()
          ..width(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_crop,h_100',
        Resize.crop(Crop()
          ..height(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_crop,g_north,h_100',
        Resize.crop(Crop()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())));
    cldAssert(
        'ar_1.5,c_crop,g_north,h_100,z_1.5',
        Resize.crop(Crop()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())
          ..zoom(1.5)));
  });

  test("Test successful crop formatting", () {
    cldAssert('c_thumb,w_100', Resize.thumbnail(Thumbnail()..width(100)));

    cldAssert(
        'ar_1.5,c_thumb,g_north,h_100,z_1.5',
        Resize.thumbnail(Thumbnail()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())
          ..zoom(1.5)));
  });

  test("Test successful crop formatting", () {
    cldAssert('c_crop,w_100', Resize.crop(Crop()..width(100)));
    cldAssert('c_crop,w_1.0', Resize.crop(Crop()..width(1.0)));
    cldAssert(
        'c_crop,h_100,w_100',
        Resize.crop(Crop()
          ..width(100)
          ..height(100)));
    cldAssert(
        'c_crop,h_1.1,w_0.5',
        Resize.crop(Crop()
          ..width(0.5)
          ..height(1.1)));
    cldAssert(
        'ar_1.5,c_crop,w_100',
        Resize.crop(Crop()
          ..width(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_crop,h_100',
        Resize.crop(Crop()
          ..height(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_crop,g_north,h_100',
        Resize.crop(Crop()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())));
    cldAssert(
        'ar_1.5,c_crop,g_north,h_100,z_1.5',
        Resize.crop(Crop()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())
          ..zoom(1.5)));
  });

  test("Test successful thumbnail formatting", () {
    cldAssert('c_thumb,w_100', Resize.thumbnail(Thumbnail()..width(100)));

    cldAssert(
        'ar_1.5,c_thumb,g_north,h_100,z_1.5',
        Resize.thumbnail(Thumbnail()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())
          ..zoom(1.5)));
  });

  test('Test successful pad formatting', () {
    cldAssert('c_pad,w_1.0', Resize.pad(Pad()..width(1.0)));
    cldAssert(
        'c_pad,h_100,w_100',
        Resize.pad(Pad()
          ..width(100)
          ..height(100)));
    cldAssert(
        'c_pad,h_1.1,w_0.5',
        Resize.pad(Pad()
          ..width(0.5)
          ..height(1.1)));
    cldAssert(
        'ar_1.5,c_pad,w_100',
        Resize.pad(Pad()
          ..width(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_pad,h_100',
        Resize.pad(Pad()
          ..height(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_pad,g_north,h_100',
        Resize.pad(Pad()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())));
    cldAssert(
        'ar_1.5,b_black,c_pad,h_100',
        Resize.pad(Pad()
          ..height(100)
          ..aspectRatio(1.5)
          ..background(Background.color(Color.black()))));
    cldAssert(
        'ar_1.5,b_auto:predominant,c_pad,h_100',
        Resize.pad(Pad()
          ..height(100)
          ..aspectRatio(1.5)
          ..background(Background.predominant())));
    cldAssert(
        'ar_1.5,b_auto:border_contrast,c_pad,h_100',
        Resize.pad(Pad()
          ..height(100)
          ..aspectRatio(1.5)
          ..background(Background.border(BorderBackground()..contrast()))));
  });

  test('Test successful limit pad formatting', () {
    print(Resize.limitPad(LimitPad()..width(100)));
    cldAssert('c_lpad,w_100', Resize.limitPad(LimitPad()..width(100)));
    cldAssert('c_lpad,w_1.0', Resize.limitPad(LimitPad()..width(1.0)));
    cldAssert(
        'c_lpad,h_100,w_100',
        Resize.limitPad(LimitPad()
          ..width(100)
          ..height(100)));
    cldAssert(
        'c_lpad,h_1.1,w_0.5',
        Resize.limitPad(LimitPad()
          ..width(0.5)
          ..height(1.1)));
    cldAssert(
        'ar_1.5,c_lpad,w_100',
        Resize.limitPad(LimitPad()
          ..width(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_lpad,h_100',
        Resize.limitPad(LimitPad()
          ..height(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_lpad,g_north,h_100',
        Resize.limitPad(LimitPad()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())));
  });

  test('Test successful minimum pad formatting', () {
    print(Resize.limitPad(LimitPad()..width(100)));
    cldAssert('c_mpad,w_100', Resize.minimumPad(MinimumPad()..width(100)));
    cldAssert('c_mpad,w_1.0', Resize.minimumPad(MinimumPad()..width(1.0)));
    cldAssert(
        'c_mpad,h_100,w_100',
        Resize.minimumPad(MinimumPad()
          ..width(100)
          ..height(100)));
    cldAssert(
        'c_mpad,h_1.1,w_0.5',
        Resize.minimumPad(MinimumPad()
          ..width(0.5)
          ..height(1.1)));
    cldAssert(
        'ar_1.5,c_mpad,w_100',
        Resize.minimumPad(MinimumPad()
          ..width(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_mpad,h_100',
        Resize.minimumPad(MinimumPad()
          ..height(100)
          ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_mpad,g_north,h_100',
        Resize.minimumPad(MinimumPad()
          ..height(100)
          ..aspectRatio(1.5)
          ..gravity(Gravity.north())));
  });
}
