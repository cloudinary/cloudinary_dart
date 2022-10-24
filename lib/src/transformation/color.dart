import 'package:cloudinary_dart/src/extensions/string_extension.dart';

class Color {
  String value;
  String? prefix;

  Color(this.value, {this.prefix});

  @override
  String toString() {
    if (prefix != null) {
      return '$prefix:$value';
    }
    return '$value';
  }

  String toStringWithPrefix(bool includedPrefix) {
    if (includedPrefix) {
      return toString();
    }
    return value;
  }

  static parseString(String color) {
    if (color.startsWith('#') || color.startsWith('rgb:')) {
      return rgb(color);
    } else {
      return named(color);
    }
  }

  static Color rgb(String hex) {
    return Color(hex.cldRemoveColorPrefixes(), prefix: 'rgb');
  }

  static Color named(String color) {
    return Color(color);
  }

  static Color snow() {
    return Color('snow');
  }

  static Color LIGHTCORAL() {
    return Color('lightcoral');
  }

  static Color BLACK() {
    return Color('black');
  }
}
