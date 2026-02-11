import 'package:cloudinary_url_gen/src/transformation/color.dart';
import 'package:cloudinary_url_gen/src/transformation/layer/position/position.dart';
import 'package:cloudinary_url_gen/src/transformation/reshape/reshape.dart';
import 'package:cloudinary_url_gen/src/transformation/resize/resize.dart';
import 'package:cloudinary_url_gen/src/transformation/source/source.dart';
import 'package:cloudinary_url_gen/src/transformation/transformation.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful reshape shear formatting', () {
    cldAssert("e_shear:20:0", Reshape.shear(20, 0));
    cldAssert("e_shear:20:0", Reshape.shear().skewX(20).skewY(0));
  });

  test('Test successful reshape distort formatting', () {
    cldAssert("e_distort:5:34:70:10:70:75:5:55",
        Reshape.distort([5, 34, 70, 10, 70, 75, 5, 55]));
  });

  test('Test successful reshape distort arc formatting', () {
    cldAssert("e_distort:arc:180", Reshape.distortArc(180));
  });

  test('Test successful reshape trim formatting', () {
    cldAssert("e_trim", Reshape.trim());
    cldAssert("e_trim:30", Reshape.trim().colorSimilarity(30));
    cldAssert("e_trim:white", Reshape.trim().colorOverride(Color.white()));
    cldAssert("e_trim:30:white",
        Reshape.trim().colorSimilarity(30).colorOverride(Color.white()));
  });

  test('Test successful reshape cutByImage with transformation', () {
    const expected =
        'l_hexagon_sample/c_scale,fl_relative,h_1,w_1/fl_cutter,fl_layer_apply';

    var scale = Transformation()
      ..resize(Resize.scale()
        ..width(1)
        ..height(1)
        ..relative = true);

    var source = Source.image("hexagon_sample", transformation: scale);

    var actual = Reshape.cutByImage(source);

    cldAssert(expected, actual);
  });

  test('Test successful reshape cutByImage with position', () {
    const expected =
        'l_hexagon_sample/c_crop,h_50,w_100/fl_cutter,fl_layer_apply,fl_tiled,x_50';

    var position = Position()
      ..offsetX(50)
      ..tiled(true);

    var crop = Transformation()
      ..resize(Resize.crop()
        ..width(100)
        ..height(50));

    var actual =
        Reshape.cutByImage(Source.image('hexagon_sample')..transformation(crop))
          ..position(position);

    cldAssert(expected, actual);
  });
}
