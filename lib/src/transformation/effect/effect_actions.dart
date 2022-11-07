import 'package:cloudinary_dart/src/extensions/string_extension.dart';

import 'effect.dart';

class Sepia extends Effect {

  dynamic level;

  Sepia([this.level]);

  @override
  String toString() {
    return 'e_sepia'.joinWithValues([level]);
  }
}