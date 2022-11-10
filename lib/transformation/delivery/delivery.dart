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

  static Dpr dpr([dynamic dpr]) {
    return Dpr(dpr);
  }
}
