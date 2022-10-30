import 'package:cloudinary_dart/src/transformation/TransformationUtils.dart';
import 'package:cloudinary_dart/src/transformation/resize/common.dart';
import 'package:cloudinary_dart/src/transformation/resize/fill.dart';
import 'package:cloudinary_dart/src/transformation/resize/fit.dart';
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
    return options.build();
  }

  /// The image is resized so that it takes up as much space as possible within a bounding box defined by the given
  /// width and height qualifiers. The original aspect ratio is retained and all of the original image is visible.
  ///
  /// Receives [Fit] and returns [Resize] object.
  static Resize fit(Fit options) {
    return options.build();
  }

  /// Same as the Scale::fit mode but only if the original image is larger than the given limit (width and
  /// height), in which case the image is scaled down so that it takes up as much space as possible within a bounding
  /// box defined by the given width and height qualifiers. The original aspect ratio is retained and all of the
  /// original image is visible.
  ///
  /// Receives [LimitFit]
  static Resize limitFit(LimitFit options) {
    return options.build();
  }

  /// Same as the Scale::fit mode but only if the original image is smaller than the given minimum (width and
  /// height), in which case the image is scaled up so that it takes up as much space as possible within a bounding
  /// box defined by the given width and height qualifiers. The original aspect ratio is retained and all of the
  /// original image is visible.
  ///
  /// Receives [MinimumFit]
  static Resize minimumFit(MinimumFit options) {
    return options.build();
  }

  /// Extracts a region of the given width and height out of the original image.
  ///
  /// Receives [Crop], returns [Resize] object.
  static Resize crop(Crop options) {
    return options.build();
  }
  /// Creates an asset with the exact given width and height without distorting the asset.
  ///
  /// This option first scales as much as needed to at least fill both of the given dimensions. If the requested
  /// aspect ratio is different than the original, cropping will occur on the dimension that exceeds the requested
  /// size after scaling.
  ///
  /// Receives [Fill], returns [Resize] object
  static Resize fill(Fill options) {
    return options.build();
  }

  /// Creates an asset with the exact given width and height without distorting the asset, but only if the original
  /// asset is larger than the specified resolution limits.
  ///
  /// The asset is scaled down to fill the given width and height without distorting the asset, and then the dimension
  /// that exceeds the request is cropped. If the original dimensions are both smaller than the requested size, it is
  /// not resized at all.
  ///
  /// Receives [LimitFill], returns [Resize] object.
  static Resize limitFill(LimitFill options) {
    return options.build();
  }
}
