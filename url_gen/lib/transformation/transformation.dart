import 'video_edit/video_edit.dart';
import 'video_edit/transcode/transcode.dart';
import 'adjust/adjust.dart';
import 'border.dart';
import 'effect/effect.dart';
import 'named_transformation.dart';
import 'resize/resize.dart';
import 'common.dart';
import 'delivery/delivery_actions.dart';
import 'rotate.dart';
import 'round_corners.dart';

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

  Transformation addTransformation(String transformation) {
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

  Transformation transcode(Transcode transcode) {
    return add(transcode);
  }

  Transformation videoEdit(VideoEdit videoEdit) {
    return add(videoEdit);
  }

  Transformation namedTransformation(dynamic namedTransformation) {
    if (namedTransformation is NamedTransformation) {
      return add(namedTransformation);
    }
    return add(NamedTransformation(namedTransformation));
  }

  TransformationObject build() {
    return TransformationObject(components);
  }

  @override
  String toString() {
    return components.join(defaultComponentSeparator);
  }
}
