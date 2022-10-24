import 'package:cloudinary_dart/src/transformation/background/background.dart';

import '../color.dart';

class ColorBackground extends Background {
  Color color;

  ColorBackground(this.color);

  @override
  String getValues() {
    return color.toString();
  }
}
