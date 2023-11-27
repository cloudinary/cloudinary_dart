import '../color.dart';
import 'background.dart';

class ColorBackground extends Background {
  Color color;

  ColorBackground(this.color);

  @override
  String getValues() {
    return color.toString();
  }
}
