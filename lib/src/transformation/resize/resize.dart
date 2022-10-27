import 'package:cloudinary_dart/src/transformation/TransformationUtils.dart';
import 'package:cloudinary_dart/src/transformation/resize/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/crop.dart';
import 'package:cloudinary_dart/src/transformation/resize/fit.dart';
import 'package:cloudinary_dart/src/transformation/resize/pad.dart';
import 'package:cloudinary_dart/src/transformation/resize/scale.dart';

import '../common.dart';

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
  /// Receives [width], [height] and/or [aspectRatio] and returns [Resize] object.
  static Resize scale(Scale options) {
    return options.build() as Resize;
  }

  /// The image is resized so that it takes up as much space as possible within a bounding box defined by the given
  /// width and height qualifiers. The original aspect ratio is retained and all of the original image is visible.
  ///
  /// Receives [Fit] and returns [Resize] object.
  static Resize fit(Fit options) {
    return options.build() as Resize;
  }

  static Resize crop(Crop options) {
    return options.build();
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
