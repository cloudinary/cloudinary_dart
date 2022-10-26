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
    cldAssert("c_scale,w_100", Resize.scale(width: 100));
    cldAssert(
        "c_scale,w_100", Resize.scale(options: ScaleBuilder()..width(100)));
    cldAssert(
        "c_scale,w_1.0", Resize.scale(options: ScaleBuilder()..width(1.0)));
    cldAssert(
        "c_scale,h_100,w_100",
        Resize.scale(
            options: ScaleBuilder()
              ..width(100)
              ..height(100)));
    cldAssert(
        "c_scale,h_1.1,w_0.5",
        Resize.scale(
            options: ScaleBuilder()
              ..width(0.5)
              ..height(1.1)));
    cldAssert(
        "ar_1.5,c_scale,w_100",
        Resize.scale(
            options: ScaleBuilder()
              ..width(100)
              ..aspectRatio(1.5)));
    cldAssert(
        "ar_1.5,c_scale,h_100",
        Resize.scale(
            options: ScaleBuilder()
              ..height(100)
              ..aspectRatio(1.5)));
    cldAssert(
        "c_scale,w_100",
        Resize.scale(
            options: ScaleBuilder()
              ..width(100)
              ..liquidRescaling(false)));
    cldAssert(
        "c_scale,g_liquid,w_100",
        Resize.scale(
            options: ScaleBuilder()
              ..width(100)
              ..liquidRescaling(true)));
  });

  test('Test successful fit formatting', () {
    cldAssert("c_fit,w_100", Resize.fit(width: 100));
    cldAssert("c_fit,w_100", Resize.fit(options: FitBuilder()..width(100)));
    cldAssert(
        "c_fit,h_100,w_100",
        Resize.fit(
            options: FitBuilder()
              ..width(100)
              ..height(100)));
    cldAssert(
        "c_fit,h_1.1,w_0.5",
        Resize.fit(
            options: FitBuilder()
              ..width(0.5)
              ..height(1.1)));
    cldAssert(
        "ar_1.5,c_fit,w_100",
        Resize.fit(
            options: FitBuilder()
              ..width(100)
              ..aspectRatio(1.5)));
    cldAssert(
        "ar_1.5,c_fit,h_100",
        Resize.fit(
            options: FitBuilder()
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

  test('Test successful pad formatting', () {
    cldAssert('c_pad,w_100', Resize.pad(width: 100));
    cldAssert('c_pad,w_1.0', Resize.pad(options: PadBuilder()..width(1.0)));
    cldAssert(
        'c_pad,h_100,w_100',
        Resize.pad(
            options: PadBuilder()
              ..width(100)
              ..height(100)));
    cldAssert('c_pad,h_100,w_100', Resize.pad(width: 100, height: 100));
    cldAssert(
        'c_pad,h_1.1,w_0.5',
        Resize.pad(
            options: PadBuilder()
              ..width(0.5)
              ..height(1.1)));
    cldAssert(
        'ar_1.5,c_pad,w_100',
        Resize.pad(
            options: PadBuilder()
              ..width(100)
              ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_pad,h_100',
        Resize.pad(
            options: PadBuilder()
              ..height(100)
              ..aspectRatio(1.5)));
    cldAssert(
        'ar_1.5,c_pad,g_north,h_100',
        Resize.pad(
            options: PadBuilder()
              ..height(100)
              ..aspectRatio(1.5)
              ..gravity(Gravity.north())));
    cldAssert(
        'ar_1.5,b_black,c_pad,h_100',
        Resize.pad(
            options: PadBuilder()
              ..height(100)
              ..aspectRatio(1.5)
              ..background(Background.color(Color.BLACK()))));
    cldAssert(
        'ar_1.5,b_auto:predominant,c_pad,h_100',
        Resize.pad(
            options: PadBuilder()
              ..height(100)
              ..aspectRatio(1.5)
              ..background(Background.predominant())));
    cldAssert(
        'ar_1.5,b_auto:border_contrast,c_pad,h_100',
        Resize.pad(
            options: PadBuilder()
              ..height(100)
              ..aspectRatio(1.5)
              ..background(
                  Background.border(BorderBackgroundBuilder()..contrast()))));
  });
}
