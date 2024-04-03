import '../transformation_utils.dart';
import '../common.dart';
import 'common.dart';
import 'crop.dart';
import 'fill.dart';
import 'fit.dart';
import 'pad.dart';
import 'scale.dart';

class Dimensions {
  dynamic width;
  dynamic height;
  dynamic aspectRatio;

  Dimensions({this.width, this.height, this.aspectRatio});

  /// Returns [Param] with the width
  Param? getWidthParam() {
    if (width != null) {
      return Param("w", width);
    }
    return null;
  }

  /// Returns [Param] with the height
  Param? getHeightParam() {
    if (height != null) {
      return Param("h", height);
    }
    return null;
  }

  /// Returns [Param] with the aspect ratio
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

  /// Sets the width
  /// Receives [dynamic] returns this object [Resize]
  Resize width(dynamic width) {
    dimensions.width = width;
    return this;
  }

  /// Sets the height
  /// Receives [dynamic] returns this object [Resize]
  Resize height(dynamic height) {
    dimensions.height = height;
    return this;
  }

  /// Sets the aspect ratio
  /// Receives [dynamic] returns this object [Resize]
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

  /// Change the size of the image exactly to the given width and height without necessarily retaining the original
  /// aspect ratio: all original image parts are visible but might be stretched or shrunk.
  ///
  /// returns [Scale] object.
  static Scale scale() {
    return Scale();
  }

  /// The image is resized so that it takes up as much space as possible within a bounding box defined by the given
  /// width and height qualifiers. The original aspect ratio is retained and all of the original image is visible.
  ///
  /// returns [Fit] object.
  static Fit fit() {
    return Fit();
  }

  /// Same as the Scale::fit mode but only if the original image is larger than the given limit (width and
  /// height), in which case the image is scaled down so that it takes up as much space as possible within a bounding
  /// box defined by the given width and height qualifiers. The original aspect ratio is retained and all of the
  /// original image is visible.
  ///
  /// returns [LimitFit]
  static LimitFit limitFit() {
    return LimitFit();
  }

  /// Same as the Scale::fit mode but only if the original image is smaller than the given minimum (width and
  /// height), in which case the image is scaled up so that it takes up as much space as possible within a bounding
  /// box defined by the given width and height qualifiers. The original aspect ratio is retained and all of the
  /// original image is visible.
  ///
  /// returns [MinimumFit]
  static MinimumFit minimumFit() {
    return MinimumFit();
  }

  /// Extracts a region of the given width and height out of the original image.
  ///
  /// returns [Crop] object.
  static Crop crop() {
    return Crop();
  }

  /// The thumb cropping mode is specifically used for creating image thumbnails from either face or custom
  /// coordinates, and must always be accompanied by the gravity qualifier set to one of the face detection or custom
  /// values.
  ///
  /// returns [Thumbnail] object.
  static Thumbnail thumbnail() {
    return Thumbnail();
  }

  /// * Resizes the image to fill the given width and height while retaining the original aspect ratio and with all of
  /// the original image visible.
  ///
  /// If the proportions of the original image do not match the given width and height,
  /// padding is added to the image to reach the required size
  ///
  /// returns [Pad] object
  static Pad pad() {
    return Pad();
  }

  /// Same as the [Pad] mode but only if the original image is larger than the given limit (width and
  /// height), in which case the image is scaled down to fill the given width and height while retaining the original
  /// aspect ratio and with all of the original image visible.
  ///
  ///This mode doesn't scale up the image if your requested dimensions are bigger than the original image's.
  ///
  /// returns [LimitPad] object
  static LimitPad limitPad() {
    return LimitPad();
  }

  /// Same as the [Pad] mode but only if the original image is smaller than the given minimum (width and
  /// height), in which case the image is scaled up to fill the given width and height while retaining the original
  /// aspect ratio and with all of the original image visible.
  ///
  ///This mode doesn't scale down the image if your requested dimensions are smaller than the original image's.
  ///
  /// returns [MinimumPad] object
  static MinimumPad minimumPad() {
    return MinimumPad();
  }

  /// Creates an asset with the exact given width and height without distorting the asset.
  ///
  /// This option first scales as much as needed to at least fill both of the given dimensions. If the requested
  /// aspect ratio is different than the original, cropping will occur on the dimension that exceeds the requested
  /// size after scaling.
  ///
  /// returns [Fill] object
  static Fill fill() {
    return Fill();
  }

  /// Creates an asset with the exact given width and height without distorting the asset, but only if the original
  /// asset is larger than the specified resolution limits.
  ///
  /// The asset is scaled down to fill the given width and height without distorting the asset, and then the dimension
  /// that exceeds the request is cropped. If the original dimensions are both smaller than the requested size, it is
  /// not resized at all.
  ///
  /// returns [LimitFill] object.
  static LimitFill limitFill() {
    return LimitFill();
  }

  static AutoPad autoPad() {
    return AutoPad();
  }
}
