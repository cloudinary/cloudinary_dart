import 'package:cloudinary_dart/src/transformation/delivery/delivery.dart';
import 'package:cloudinary_dart/src/transformation/resize/resize.dart';

import 'common.dart';

class TransformationObject {
  List<Action> actions = [];

  TransformationObject(this.actions);

  @override
  String toString() {
    return actions.join(defaultComponentSeparator);
  }

  void add(Action action) {
    actions.add(action);
  }

  static TransformationObject transformation(Transformation options) {
    var builder = Transformation();
    builder.copyWith(options);
    return builder.build();
  }
}

class Transformation {
  List<Action> components = [];

  Transformation add(Action action) {
    components.add(action);
    return this;
  }

  Transformation delivery(DeliveryAction delivery) {
    return add(delivery);
  }

  Transformation generic(String transformation) {
    return add(GenericAction(transformation));
  }

  Transformation resize(Resize resize) {
    return add(resize);
  }

  TransformationObject build() {
    return TransformationObject(components);
  }

  void copyWith(Transformation other) {
    components = other.components;
  }
}

/// Class Transformation Builder
abstract class TransformationComponentBuilder<T> {
  void copyWith(T other);
}
