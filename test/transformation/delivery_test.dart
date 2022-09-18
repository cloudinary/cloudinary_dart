import 'package:cloudinary_dart/src/asset/format.dart';
import 'package:cloudinary_dart/src/transformation/delivery/delivery.dart';
import 'package:cloudinary_dart/src/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_dart/src/transformation/delivery/quality.dart';
import 'package:test/test.dart';
import '../tests_utils.dart';

void main() {
  test('Test successful quality formatting', () {
    cldAssert("q_100", Delivery.quality(100));
    cldAssert("q_100:420", Delivery.quality(100, options: QualityBuilder().chromaSubSampling(ChromaSubSampling.chroma420())));
    cldAssert("q_auto", Delivery.quality(Quality.auto()));
    cldAssert("q_auto:low", Delivery.quality(Quality.autoLow()));
    cldAssert("q_auto:low:444", Delivery.quality(Quality.autoLow(), options: QualityBuilder().chromaSubSampling(ChromaSubSampling.chroma444())));
    cldAssert("q_70:qmax_80", Delivery.quality(70, options: QualityBuilder().quantization(80)));
    cldAssert("q_jpegmini:0", Delivery.quality(Quality.jpegminiBest()));
    cldAssert("q_jpegmini:1", Delivery.quality(Quality.jpegminiHigh()));
    cldAssert("q_jpegmini:2", Delivery.quality(Quality.jpegminiMedium()));
  });

  test('Test quality with any format parameter', () {
    cldAssert("fl_any_format,q_auto", Delivery.quality(Quality.auto(), options: QualityBuilder(anyFormat: true)));

    cldAssert("fl_any_format,q_auto", Delivery.quality(Quality.auto(), options: QualityBuilder()..anyFormat(true)));
  });
}

