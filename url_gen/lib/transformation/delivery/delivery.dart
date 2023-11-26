import 'delivery_actions.dart';

/// Defines transformations for delivering your assets without changing the visual or audio experience
/// for the end user.
///
/// **Learn more**: <a href=https://cloudinary.com/documentation/image_delivery_options target="_blank">
/// Media delivery</a>
abstract class Delivery {
  /// Controls compression quality. 1 is the lowest quality and 100 is the
  /// highest.
  ///
  /// Reducing the quality is a trade-off between visual quality and file size.
  ///
  /// returns [Quality]
  static Quality quality(dynamic level) {
    return Quality(level);
  }

  /// Forces format conversion to the given format.
  /// (Formerly known as fetch format)
  ///
  /// returns [Format] object
  static Format format([String? format]) {
    return Format(format);
  }

  /// Deliver the image in the specified device pixel ratio.
  ///
  /// dpr [dynamic] The DPR (Device Pixel Ratio). Any positive float value.
  static Dpr dpr([dynamic dpr]) {
    return Dpr(dpr);
  }

  static ColorSpaceFromICC colorSpaceFromICC(String publicId) {
    return ColorSpaceFromICC(publicId);
  }

  static Density density(dynamic density) {
    return Density(density);
  }

  static ColorSpace colorSpace(dynamic colorSpace) {
    return ColorSpace(colorSpace);
  }
}
