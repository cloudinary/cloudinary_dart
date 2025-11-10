import '../source/image_source.dart';

import '../common.dart';
import '../transformation.dart';

abstract class Source {
  Transformation? transformationObject;

  static ImageSource image(String publicId, {Transformation? transformation}) {
    return ImageSource(publicId, transformation: transformation);
  }

  List<Param> extraComponents();
}
