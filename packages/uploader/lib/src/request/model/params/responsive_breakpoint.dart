import 'package:cloudinary_dart_url_gen/transformation/transformation.dart';

class ResponsiveBreakpoint {
  bool? createDerived;
  Transformation? transformation;
  int? maxWidth;
  int? minWidth;
  int? byteStep;
  int? maxImages;

  ResponsiveBreakpoint({this.createDerived, this.transformation, this.byteStep, this.maxImages, this.maxWidth, this.minWidth});
}