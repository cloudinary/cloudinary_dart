import 'package:cloudinary_dart/transformation/common.dart';

class Rotate extends Action {

  dynamic _rotation;

  Rotate(dynamic rotation) {
    _rotation = rotation;
  }

  @override
  String toString() {
    return 'a_$_rotation';
  }

  static byAngle(dynamic angle) => Rotate(angle);
  static mode(RotationMode mode) => Rotate(mode);
}

class RotationMode {
  String value;

  RotationMode(this.value);

  static autoRight() => RotationMode('auto_right');
  static autoLeft() => RotationMode('auto_left');
  static ignore() => RotationMode('ignore');
  static verticalFlip() => RotationMode('vflip');
  static horizontalFlip() => RotationMode('hflip');

  @override
  String toString() {
    return value;
  }
}