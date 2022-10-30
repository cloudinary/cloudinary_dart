import 'package:cloudinary_dart/src/transformation/delivery/delivery_actions.dart';
import '../common.dart';

/// Defines transformations for delivering your assets without changing the visual or audio experience
/// for the end user.
///
/// **Learn more**: <a href=https://cloudinary.com/documentation/image_delivery_options target="_blank">
/// Media delivery</a>
abstract class Delivery implements Action {
  /// Controls compression quality. 1 is the lowest quality and 100 is the
  /// highest.
  ///
  /// Reducing the quality is a trade-off between visual quality and file size.
  ///
  /// Receives [Quality]
  ///
  static Quality quality(Quality options) {
    return options;
  }

  /// Forces format conversion to the given format.
  /// (Formerly known as fetch format)
  ///
  /// Receives[Format]
  /// Returns occupied [DeliveryFormat] object
  static Format format(Format options) {
    return options;
  }
}
