import 'package:cloudinary_dart/src/transformation/TransformationUtils.dart';
import 'package:cloudinary_dart/src/transformation/resize/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/fit.dart';
import 'package:cloudinary_dart/src/transformation/resize/scale.dart';

import '../common.dart';
import 'pad.dart';
import 'crop.dart';

class Dimensions {
  dynamic width;
  dynamic height;
  dynamic aspectRatio;

  Dimensions({this.width, this.height, this.aspectRatio});

  Param? getWidthParam() {
    if (width != null) {
      return Param("w", width);
    }
    return null;
  }

  Param? getHeightParam() {
    if (height != null) {
      return Param("h", height);
    }
    return null;
  }

  Param? getAspectRatioParam() {
    if (aspectRatio != null) {
      return Param("ar", aspectRatio);
    }
    return null;
  }
}

/// Class Resize
abstract class Resize extends Action {
  Dimensions dimensions;
  bool? relative;
  bool? regionRelative;
  abstract String actionType;

  Resize(this.dimensions, {this.relative, this.regionRelative});

  @override
  String toString() {
    return toComponentString(params());
  }

  List<Param?> params() {
    return [
      Param("c", actionType),
      dimensions.getWidthParam(),
      dimensions.getHeightParam(),
      (relative == true) ? Param("fl", "relative") : null,
      (regionRelative == true) ? Param("fl", "region_relative") : null,
      (dimensions.aspectRatio == AspectRatio.ignoreInitialAspectRatio)
          ? Param("fl", "ignore_aspect_ratio")
          : dimensions.getAspectRatioParam()
    ];
  }

  /// Change the size of the image exactly to the given width and height without necessarily retaining the original
  /// aspect ratio: all original image parts are visible but might be stretched or shrunk.
  ///
  /// Receives [width], [height], [aspectRatio] and options, returns [Resize] object.
  static Resize scale({int? width, int? height, ScaleBuilder? options}) {
    var builder = ScaleBuilder();
    builder.width(width);
    builder.height(height);
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  /// The image is resized so that it takes up as much space as possible within a bounding box defined by the given
  /// width and height qualifiers. The original aspect ratio is retained and all of the original image is visible.
  ///
  /// Receives [width], [height], [aspectRatio] and options, returns [Resize] object.
  static Resize fit({int? width, int? height, FitBuilder? options}) {
    var builder = FitBuilder(width: width, height: height);
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  /// Extracts a region of the given width and height out of the original image.
  ///
  /// Receives [width], [height], [aspectRatio] and options, returns [Resize] object.
  static Resize crop({int? width, int? height, CropBuilder? options}) {
    var builder = CropBuilder();
    builder.width(width);
    builder.height(height);
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  static Resize pad({int? width, int? height, PadBuilder? options}) {
    var builder = PadBuilder();
    builder.width(width);
    builder.height(height);
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }
}
