import 'package:cloudinary_url_gen/cloudinary.dart';

class EagerTransformation {
  Transformation transformation;
  String? extension;

  EagerTransformation(this.transformation, {this.extension});

  EagerTransformation.withFormat(this.transformation, String format) {
    extension = format;
  }
}
