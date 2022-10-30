import 'package:cloudinary_dart/transformation/delivery/delivery.dart';
import 'package:cloudinary_dart/transformation/delivery/delivery_actions.dart';
import 'package:test/test.dart';
import '../tests_utils.dart';

void main() {
  test('Test successful quality formatting', () {
    cldAssert("q_100", Delivery.quality(Quality(100)));
    cldAssert(
        "q_100:420",
        Delivery.quality(
            Quality(100)..chromaSubSampling(ChromaSubSampling.chroma420())));
    cldAssert(
        "q_100:420",
        Delivery.quality(
            Quality(100)..chromaSubSampling(ChromaSubSampling.chroma420())));
    print(Delivery.quality(Quality(Quality.auto)));
    cldAssert("q_auto", Delivery.quality(Quality(Quality.auto)));
    cldAssert("q_auto:low", Delivery.quality(Quality(Quality.autoLow)));
    cldAssert(
        "q_auto:low:444",
        Delivery.quality(Quality(Quality.autoLow)
          ..chromaSubSampling(ChromaSubSampling.chroma444())));
    cldAssert("q_70:qmax_80", Delivery.quality(Quality(70)..quantization(80)));
    cldAssert("q_jpegmini:0", Delivery.quality(Quality(Quality.jpegminiBest)));
    cldAssert("q_jpegmini:1", Delivery.quality(Quality(Quality.jpegminiHigh)));
    cldAssert(
        "q_jpegmini:2", Delivery.quality(Quality(Quality.jpegminiMedium)));
  });

  test('Test quality with any format parameter', () {
    cldAssert("fl_any_format,q_auto",
        Delivery.quality(Quality(Quality.auto)..anyFormat(true)));
    cldAssert("fl_any_format,q_auto",
        Delivery.quality(Quality(Quality.auto)..anyFormat(true)));
  });

  group('Test format class', () {
    test('Test format syntax successful', () {
      cldAssert("f_png", Delivery.format(Format(Format.png)));
    });

    test('Test format syntax successful with progressive option', () {
      cldAssert("f_jpg,fl_progressive:semi",
          Delivery.format(Format(Format.jpg).progressive(Progressive.semi())));
      cldAssert(
          'f_png,fl_progressive:semi',
          Delivery.format(
              Format.withString('png').progressive(Progressive.semi())));
    });

    test('Test format syntax with options', () {
      cldAssert(
          "f_jpg,fl_lossy,fl_preserve_transparency,fl_progressive,fl_ignore_mask_channels",
          Delivery.format(Format(Format.jpg)
              .lossy()
              .progressive(Progressive.progressive())
              .preserveTransparency()
              .ignoreMaskChannels()));
      cldAssert(
          "f_jpg,fl_lossy,fl_preserve_transparency,fl_progressive,fl_ignore_mask_channels",
          Delivery.format(Format(Format.jpg)
            ..lossy(true)
            ..progressive(Progressive.progressive())
            ..preserveTransparency()
            ..ignoreMaskChannels()));
    });
  });
}
