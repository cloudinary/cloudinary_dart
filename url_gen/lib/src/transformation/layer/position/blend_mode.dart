import '../../../extensions/string_extension.dart';

class BlendMode {
  String value;

  BlendMode(this.value);

  static screen() => BlendMode('screen');
  static multiply() => BlendMode('multiply');
  static overlay() => BlendMode('overlay');
  static mask() => BlendMode('mask');
  static antiRemoval() => AntiRemovalBlendMode('anti_removal');

  @override
  String toString() {
    return value;
  }
}

class AntiRemovalBlendMode extends BlendMode {
  dynamic _level;

  AntiRemovalBlendMode(super.value);

  AntiRemovalBlendMode level(dynamic level) {
    _level = level;
    return this;
  }

  @override
  String toString() {
    return super.toString().joinWithValues([_level]);
  }
}
