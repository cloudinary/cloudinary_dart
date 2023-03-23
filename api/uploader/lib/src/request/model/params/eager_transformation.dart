import 'package:cloudinary_url_gen_dart/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_url_gen_dart/transformation/transformation.dart';

class EagerTransformation {
  Transformation transformation;
  String? extension;

  EagerTransformation(this.transformation, {this.extension});

  EagerTransformation.withFormat(this.transformation, String format) {
    extension = format;
  }
}
