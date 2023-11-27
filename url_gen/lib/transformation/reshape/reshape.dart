import 'package:cloudinary_url_gen/transformation/reshape/reshape_actions.dart';
import 'package:cloudinary_url_gen/transformation/source/source.dart';

import '../common.dart';

class Reshape extends Action {
  static Shear shear([dynamic skewX, dynamic skewY]) {
    return Shear(skewX: skewX, skewY: skewY);
  }

  static Distort distort(List<dynamic> points) {
    return Distort(points);
  }

  static DistortArc distortArc(dynamic degrees) {
    return DistortArc(degrees);
  }

  static Trim trim([dynamic colorSimilarity, dynamic colorOverride]) {
    return Trim(colorSimilarity, colorOverride);
  }

  static CutByImage cutByImage(Source source) {
    return CutByImage(source);
  }

  //TODO: missing Source , ImageSource, TextSource, FetchSource

  @override
  String toString() {
    return 'e';
  }
}
