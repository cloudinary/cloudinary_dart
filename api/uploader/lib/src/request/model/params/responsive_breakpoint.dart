import 'package:cloudinary_url_gen_dart/transformation/transformation.dart';

class ResponsiveBreakpoint {
  bool? createDerived;
  String? format;
  Transformation? transformation;
  int? maxWidth;
  int? minWidth;
  int? byteStep;
  int? maxImages;

  ResponsiveBreakpoint(
      {this.createDerived,
      this.format,
      this.transformation,
      this.byteStep,
      this.maxImages,
      this.maxWidth,
      this.minWidth});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {};
    (createDerived != null)
        ? result
            .addEntries({'create_derived': createDerived.toString()}.entries)
        : null;
    (format != null)
        ? result.addEntries({'format': format.toString()}.entries)
        : null;
    (transformation != null)
        ? result
            .addEntries({'transformation': transformation.toString()}.entries)
        : null;
    (byteStep != null)
        ? result.addEntries({'byte_step': byteStep.toString()}.entries)
        : null;
    (maxImages != null)
        ? result.addEntries({'max_images': maxImages.toString()}.entries)
        : null;
    (maxWidth != null)
        ? result.addEntries({'max_width': maxWidth.toString()}.entries)
        : null;
    (minWidth != null)
        ? result.addEntries({'min_width': minWidth.toString()}.entries)
        : null;
    return result;
  }

  factory ResponsiveBreakpoint.fromJson(Map<String, dynamic> data) {
    final createdDerived = data['create_derived'] as bool?;
    final transformation = data['transformation'] as Transformation?;
    final format = data['format'] as String?;
    final maxWidth = data['max_width'] as int?;
    final minWidth = data['min_width'] as int?;
    final maxImages = data['max_images'] as int?;
    return ResponsiveBreakpoint(
        createDerived: createdDerived,
        transformation: transformation,
        format: format,
        maxWidth: maxWidth,
        minWidth: minWidth,
        maxImages: maxImages);
  }
}
