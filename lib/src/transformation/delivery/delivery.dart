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

//   fun format(format: DeliveryFormat) = format
//   fun format(format: Format, options: (DeliveryFormat.Builder.() -> Unit)? = null): DeliveryFormat {
//   val builder = DeliveryFormat.Builder(format)
//   options?.let { builder.it() }
// return builder.build()
// }
}