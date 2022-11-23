import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/transformation/common.dart';

/// Defines the objects that can be focused on.
class FocusOn {
  String value;
  int? _weight;
  bool? _avoid;

  FocusOn(this.value);

  static FocusOn ocr() => FocusOn("ocr");
  static FocusOn bicycle() => FocusOn("bicycle");
  static FocusOn cat() => FocusOn("cat");
  static FocusOn dog() => FocusOn("dog");
  static FocusOn bird() => FocusOn("bird");
  static FocusOn microwave() => FocusOn("microwave");
  static FocusOn refrigerator() => FocusOn("refrigerator");
  static FocusOn sink() => FocusOn("sink");
  static FocusOn skateboard() => FocusOn("ocr");
  static FocusOn bottle() => FocusOn("bottle");
  static FocusOn advancedFace() => FocusOn("advancedFace");
  static FocusOn advancedFaces() => FocusOn("advancedFaces");
  static FocusOn advancedEyes() => FocusOn("advancedEyes");
  static FocusOn body() => FocusOn("body");
  static FocusOn face() => FocusOn("face");
  static FocusOn faces() => FocusOn("faces");
  static FocusOn noFaces() => FocusOn("no_faces");
  static FocusOn customNoOverride() => FocusOn("custom_no_override");
  static FocusOn person() => FocusOn("person");
  static FocusOn classic() => FocusOn("classic");
  static FocusOn subject() => FocusOn("subject");

  FocusOn weight(int weight) {
    _weight = weight;
    return this;
  }

  FocusOn avoid() {
    _avoid = true;
    return this;
  }

  @override
  String toString() {
    var weightStr = (_avoid != null && _avoid == true)
        ? "avoid"
        : (_weight != null)
            ? _weight.toString()
            : null;
    return value.joinWithValues([weightStr], separator: paramKeyValueSeparator);
  }
}
