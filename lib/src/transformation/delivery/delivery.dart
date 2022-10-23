import 'package:cloudinary_dart/src/transformation/delivery/delivery_actions.dart';

import '../../../asset/format.dart';
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
  static QualityAction quality(Quality options) {
    return options.build();
  }

  /// Forces format conversion to the given format.
  /// (Formerly known as fetch format)
  ///
  /// /// Receives a [String] object with the relevant format type and [FormatBuilder] with extra options
  /// Returns occupied [DeliveryFormat] object
  static FormatAction formatWithString(String value, {FormatBuilder? options}) {
    var builder = FormatBuilder(format: Format.custom(value));
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  /// Forces format conversion to the given format.
  /// (Formerly known as fetch format)
  ///
  /// Receives a [Format] object with the relevant format type and [FormatBuilder] with extra options
  /// Returns occupied [DeliveryFormat] object
  static FormatAction format(Format format, {FormatBuilder? options}) {
    var builder = FormatBuilder(format: format);
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }
}
