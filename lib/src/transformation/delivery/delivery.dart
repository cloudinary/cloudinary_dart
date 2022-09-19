import 'package:cloudinary_dart/src/asset/format.dart';
import 'package:cloudinary_dart/src/transformation/delivery/delivery_actions.dart';

import '../common.dart';
import 'delivery_actions.dart';

abstract class Delivery implements Action {
  static QualityAction quality(dynamic level, {QualityBuilder? options}) {
    var builder = QualityBuilder(level: level);
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

  static DeliveryFormat format(DeliveryFormat format) {
    return format;
  }

  static DeliveryFormat formatWithString(String value) {
    var builder = FormatBuilder(format: Format.custom(value));
    return builder.build();
  }

  static DeliveryFormat formatWithOptions(Format format, {FormatBuilder? options}) {
    var builder = FormatBuilder(format: format);
    if(options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }

//   fun format(format: DeliveryFormat) = format
//   fun format(format: Format, options: (DeliveryFormat.Builder.() -> Unit)? = null): DeliveryFormat {
//   val builder = DeliveryFormat.Builder(format)
//   options?.let { builder.it() }
// return builder.build()
// }
}