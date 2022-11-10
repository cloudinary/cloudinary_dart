import '../common.dart';
import 'adjust_actions.dart';

class Adjust extends Action {
  static Opacity opacity([dynamic level]) {
    return Opacity(level);
  }

  static Tint tint([String? options]) {
    return Tint(options);
  }

  static Vibrance vibrance([dynamic strength]) {
    return Vibrance('vibrance', strength);
  }

  static AutoColor autoColor([dynamic blend]) {
    return AutoColor(blend);
  }

  static Brightness brightness([dynamic level]) {
    return Brightness('brightness', level);
  }

  @override
  String toString() {
    return 'e';
  }
}