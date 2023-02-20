import 'package:cloudinary_dart_url_gen/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_dart_url_gen/transformation/transformation.dart';

class EagerTransformation {
  Transformation transformation;
  String? extension;

  EagerTransformation(this.transformation, this.extension);

  EagerTransformation.withFormat(this.transformation, Format format) {
    extension = format.toString();
  }
}
