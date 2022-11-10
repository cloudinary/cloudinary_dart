import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/transformation/transformation.dart';

import 'focus_on.dart';

/// Defines the focal gravity for certain methods of cropping.
///
/// **Learn more
/// https://cloudinary.com/documentation/image_transformations#control_gravity
/// https://cloudinary.com/documentation/video_manipulation_and_delivery#gravity

class Gravity {
  /// North west corner (bottom).
  ///
  /// Returns [CompassGravity]
  static south() => CompassGravity(Compass.south());

  /// North west corner (bottom right).
  ///
  /// Returns [CompassGravity]
  static southEast() => CompassGravity(Compass.southEast());

  /// North west corner (bottom left).
  ///
  /// Returns [CompassGravity]
  static southWest() => CompassGravity(Compass.southWest());

  /// North west corner (left).
  ///
  /// Returns [CompassGravity]
  static west() => CompassGravity(Compass.west());

  /// North west corner (right).
  ///
  /// Returns [CompassGravity]
  static east() => CompassGravity(Compass.east());

  /// North west corner (top).
  ///
  /// Returns [CompassGravity]
  static north() => CompassGravity(Compass.north());

  /// North west corner (top right).
  ///
  /// Returns [CompassGravity]
  static northEast() => CompassGravity(Compass.northEast());

  /// North west corner (top left).
  ///
  /// Returns [CompassGravity]
  static northWest() => CompassGravity(Compass.northWest());

  /// North west corner (center).
  ///
  /// Returns [CompassGravity]
  static center() => CompassGravity(Compass.center());

  static xyCenter() => XYCenterGravity();

  FocusOnGravityQualifier focusOn(List<FocusOn> focusOnObjects,
      {FocusOnGravity? options}) {
    var builder = FocusOnGravity(focusOnObjects);
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }
}

///Class CompassGravity
class CompassGravity extends Gravity {
  Compass compass;

  CompassGravity(this.compass);

  @override
  String toString() {
    return compass.toString();
  }
}

/// Class Compass
class Compass {
  String value;

  Compass(this.value);

  static north() => Compass('north');
  static northEast() => Compass('northEast');
  static northWest() => Compass('northWest');
  static east() => Compass('east');
  static southEast() => Compass('southEast');
  static south() => Compass('south');
  static southWest() => Compass('southWest');
  static west() => Compass('west');
  static center() => Compass('center');

  @override
  String toString() {
    return value;
  }
}

/// Class FocusOnGravity
///  Defines objects to use as the focal gravity of crops.
///
/// Learn More
/// https://cloudinary.com/documentation/cloudinary_object_aware_cropping_addon
class FocusOnGravityQualifier extends Gravity {
  List<FocusOn> focusOnObjects;
  AutoGravity? fallbackGravity;

  FocusOnGravityQualifier(this.focusOnObjects, this.fallbackGravity);

  @override
  String toString() {
    return focusOnObjects
        .join(":")
        .joinWithValues([fallbackGravity.toString()]);
  }
}

/// Class FocusOnGravityBuilder
class FocusOnGravity implements GeneralBuilder {
  List<FocusOn> objects;
  AutoGravity? _fallbackGravity;

  FocusOnGravity(this.objects);

  FocusOnGravity fallbackGravity(AutoGravity graviy) {
    _fallbackGravity = graviy;
    return this;
  }

  FocusOnGravityQualifier build() {
    return FocusOnGravityQualifier(objects, _fallbackGravity);
  }

  @override
  void copyWith(other) {
    objects = other.objects;
    _fallbackGravity = other._fallbackGravity;
  }
}

/// Automatically identifies the most interesting regions to include when resizing.
///
/// Learn more
/// "https://cloudinary.com/documentation/image_transformations#automatic_cropping_g_auto"
/// Automatic gravity for images
/// "https://cloudinary.com/documentation/video_manipulation_and_delivery#automatic_cropping"
/// Automatic gravity for videos
class AutoGravityQualifier extends Gravity {
  List<FocusOn> objects;

  AutoGravityQualifier(this.objects);

  @override
  String toString() {
    return "auto".joinWithValues(objects);
  }
}

class AutoGravity {
  List<FocusOn> objects = [];

  AutoGravity autoFocusOn(List<FocusOn> objects) {
    this.objects.addAll(objects);
    return this;
  }

  build() {
    return AutoGravityQualifier(objects);
  }
}

/// Class AutoFocus
/// Defines the objects that can be focused on.
class AutoFocusQualifier {
  static AutoGravityObjectQualifier focusOn(FocusOn focus,
      {AutoGravityObject? options}) {
    var builder = AutoGravityObject(focus);
    options ?? builder.copyWith(options);
    return builder.build();
  }
}

class AutoGravityObjectQualifier {
  FocusOn gravityObject;
  int? weight;
  bool? avoid;

  AutoGravityObjectQualifier(this.gravityObject, {this.weight, this.avoid});

  @override
  String toString() {
    var weightStr =
        (avoid != null && avoid == true) ? "avoid" : weight.toString();
    return '$gravityObject'.joinWithValues([weightStr], separator: "_");
  }
}

class AutoGravityObject implements GeneralBuilder {
  FocusOn focusOn;
  int? _weight;
  bool? _avoid;

  AutoGravityObject(this.focusOn);

  AutoGravityObject weight(int weight) {
    _weight = weight;
    return this;
  }

  AutoGravityObject avoid() {
    _avoid = true;
    return this;
  }

  AutoGravityObjectQualifier build() {
    return AutoGravityObjectQualifier(focusOn, weight: _weight, avoid: _avoid);
  }

  @override
  void copyWith(other) {
    focusOn = other.focusOn;
    _weight = other._weight;
    _avoid = other._avoid;
  }
}

class XYCenterGravity extends Gravity {
  @override
  String toString() {
    return 'xy_center';
  }
}
