import 'package:cloudinary_dart/src/transformation/TransformationUtils.dart';
import 'package:cloudinary_dart/src/transformation/resize/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/fit.dart';
import 'package:cloudinary_dart/src/transformation/resize/pad.dart';
import 'package:cloudinary_dart/src/transformation/resize/scale.dart';

import '../common.dart';
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
  late Dimensions dimensions;
  bool? relative;
  bool? regionRelative;
  abstract String actionType;

  Resize({Dimensions? dimensions, this.relative, this.regionRelative}) {
    if (dimensions == null) {
      this.dimensions = Dimensions();
    } else {
      this.dimensions = dimensions;
    }
  }

  Resize width(dynamic width) {
    dimensions.width = width;
    return this;
  }

  Resize height(dynamic height) {
    dimensions.height = height;
    return this;
  }

  Resize aspectRatio(dynamic aspectRatio) {
    dimensions.aspectRatio = aspectRatio;
    return this;
  }

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

  /// Receives [width], [height] and/or [aspectRatio] and returns [Resize] object.
  static Resize scale(Scale scale) {
    return scale;
  }

  /// The image is resized so that it takes up as much space as possible within a bounding box defined by the given
  /// width and height qualifiers. The original aspect ratio is retained and all of the original image is visible.
  ///
  /// Receives [Fit] and returns [Resize] object.
  static Resize fit(Fit fit) {
    return fit;
  }

  /// Same as the Scale::fit mode but only if the original image is larger than the given limit (width and
  /// height), in which case the image is scaled down so that it takes up as much space as possible within a bounding
  /// box defined by the given width and height qualifiers. The original aspect ratio is retained and all of the
  /// original image is visible.
  ///
  /// Receives [LimitFit]
  static Resize limitFit(LimitFit limitFit) {
    return limitFit;
  }

  /// Same as the Scale::fit mode but only if the original image is smaller than the given minimum (width and
  /// height), in which case the image is scaled up so that it takes up as much space as possible within a bounding
  /// box defined by the given width and height qualifiers. The original aspect ratio is retained and all of the
  /// original image is visible.
  ///
  /// Receives [MinimumFit]
  static Resize minimumFit(MinimumFit minimumFit) {
    return minimumFit;
  }

  /// Extracts a region of the given width and height out of the original image.
  ///
  /// Receives [width], [height], [aspectRatio] and options, returns [Resize] object.
  static Resize crop(Crop crop) {
    return crop;
  }

  /// * Resizes the image to fill the given width and height while retaining the original aspect ratio and with all of
  /// the original image visible.
  ///
  /// If the proportions of the original image do not match the given width and height,
  /// padding is added to the image to reach the required size
  ///
  /// Receives [Pad] returns [Resize] object
  static Resize pad(Pad options) {
    return options.build();
  }

  /// Same as the [Pad] mode but only if the original image is larger than the given limit (width and
  /// height), in which case the image is scaled down to fill the given width and height while retaining the original
  /// aspect ratio and with all of the original image visible.
  ///
  ///This mode doesn't scale up the image if your requested dimensions are bigger than the original image's.
  ///
  /// Receives [LimitPad] returns [Resize] object
  static Resize limitPad(LimitPad options) {
    return options.build();
  }

  /// Same as the [Pad] mode but only if the original image is smaller than the given minimum (width and
  /// height), in which case the image is scaled up to fill the given width and height while retaining the original
  /// aspect ratio and with all of the original image visible.
  ///
  ///This mode doesn't scale down the image if your requested dimensions are smaller than the original image's.
  ///
  /// Receives [MinimumPad] returns [Resize] object
  static Resize minimumPad(MinimumPad options) {
    return options.build();
  }
}
