/// Defines the objects that can be focused on.
enum FocusOn {
  ocr,
  bicycle,
  cat,
  dog,
  bird,
  microwave,
  refrigerator,
  sink,
  skateboard,
  bottle,
  advancedFace,
  advancedFaces,
  advancedEyes,
  body,
  face,
  faces,
  no_faces,
  custom_no_override,
  person,
  classic,
  subject
}

extension ParseToString on FocusOn {
  String toShortString() {
    return toString().split('.').last;
  }
}
