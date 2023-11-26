import 'package:test/test.dart';
import '../../lib/transformation/delivery/delivery.dart';
import '../../lib/transformation/delivery/delivery_actions.dart';
import '../tests_utils.dart';

void main() {
  test('Test successful quality formatting', () {
    cldAssert("q_100", Delivery.quality(100));
    cldAssert(
        "q_100:420",
        Delivery.quality(100)
          ..chromaSubSampling(ChromaSubSampling.chroma420()));
    cldAssert(
        "q_100:420",
        Delivery.quality(100)
          ..chromaSubSampling(ChromaSubSampling.chroma420()));
    cldAssert("q_auto", Delivery.quality(Quality.auto()));
    cldAssert("q_auto:low", Delivery.quality(Quality.autoLow()));
    cldAssert(
        "q_auto:low:444",
        Delivery.quality(Quality.autoLow())
          ..chromaSubSampling(ChromaSubSampling.chroma444()));
    cldAssert("q_70:qmax_80", Delivery.quality(70)..quantization(80));
    cldAssert("q_jpegmini:0", Delivery.quality(Quality.jpegminiBest()));
    cldAssert("q_jpegmini:1", Delivery.quality(Quality.jpegminiHigh()));
    cldAssert("q_jpegmini:2", Delivery.quality(Quality.jpegminiMedium()));
  });

  test('Test quality with any format parameter', () {
    cldAssert("fl_any_format,q_auto",
        Delivery.quality(Quality.auto())..anyFormat(true));
    cldAssert("fl_any_format,q_auto",
        Delivery.quality(Quality.auto())..anyFormat(true));
  });

  group('Test format class', () {
    test('Test format syntax successful', () {
      cldAssert("f_png", Delivery.format(Format.png));
    });

    test('Test format syntax successful with progressive option', () {
      cldAssert("f_jpg,fl_progressive:semi",
          Delivery.format(Format.jpg)..progressive(Progressive.semi()));
      cldAssert('f_png,fl_progressive:semi',
          Delivery.format('png').progressive(Progressive.semi()));
    });

    test('Test format syntax with options', () {
      cldAssert(
          "f_jpg,fl_lossy,fl_preserve_transparency,fl_progressive,fl_ignore_mask_channels",
          Delivery.format(Format.jpg)
              .lossy()
              .progressive(Progressive.progressive())
              .preserveTransparency()
              .ignoreMaskChannels());
      cldAssert(
          "f_jpg,fl_lossy,fl_preserve_transparency,fl_progressive,fl_ignore_mask_channels",
          Delivery.format(Format.jpg)
            ..lossy(true)
            ..progressive(Progressive.progressive())
            ..preserveTransparency()
            ..ignoreMaskChannels());
    });
  });

  test('Test dpr syntax with options', () {
    cldAssert("dpr_auto", Delivery.dpr(Dpr.auto));
    cldAssert("dpr_2:3", Delivery.dpr("2:3"));
    cldAssert("dpr_1.5", Delivery.dpr(1.5));
    cldAssert('dpr_2', Delivery.dpr(2));
  });

  test('Test density syntax', () {
    cldAssert('dn_150', Delivery.density(150));
  });

  test('Test delivery color space from icc syntax', () {
    cldAssert('cs_icc:test_public_id', Delivery.colorSpaceFromICC('test_public_id'));
  });
}
