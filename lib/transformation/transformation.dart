import 'package:cloudinary_dart/transformation/adjust/adjust.dart';
import 'package:cloudinary_dart/transformation/rotate.dart';
import 'package:cloudinary_dart/transformation/round_corners.dart';
import 'border.dart';
import 'effect/effect.dart';
import 'resize/resize.dart';
import 'common.dart';
import 'delivery/delivery_actions.dart';

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

  Transformation rotate(Rotate rotate) {
    return add(rotate);
  }

  Transformation adjust(Adjust adjust) {
    return add(adjust);
  }

  Transformation effect(Effect effect) {
    return add(effect);
  }

  Transformation roundCorners(dynamic value) {
    if (value is RoundCorners) {
      return add(value);
    }
    return add(RoundCorners(value));
  }

  Transformation border(Border border) {
    return add(border);
  }

  TransformationObject build() {
    return TransformationObject(components);
  }

  void copyWith(Transformation other) {
    components = other.components;
  }

  @override
  String toString() {
    return components.join(defaultComponentSeparator);
  }
}

/// Class Transformation Builder
abstract class TransformationComponentBuilder<T> {
  void copyWith(T other);
}

abstract class GeneralBuilder<T> {
  void copyWith(T other);
}
