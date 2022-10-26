import 'package:cloudinary_dart/src/transformation/resize/fit.dart';
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
}
