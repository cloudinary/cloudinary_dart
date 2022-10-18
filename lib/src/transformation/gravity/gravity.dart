import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/transformation/transformation.dart';

import 'focus_on.dart';

class Gravity {
  static south() => CompassGravity(Compass.south());
  static southEast() => CompassGravity(Compass.southEast());
  static southWest() => CompassGravity(Compass.southWest());
  static west() => CompassGravity(Compass.west());
  static east() => CompassGravity(Compass.east());
  static north() => CompassGravity(Compass.north());
  static northEast() => CompassGravity(Compass.northEast());
  static northWest() => CompassGravity(Compass.northWest());
  static center() => CompassGravity(Compass.center());

  FocusOnGravity focusOn(FocusOn focusOn,List<FocusOn> focusOnObjects, {FocusOnGravityBuilder? options}) {
    List<FocusOn> list = [focusOn];
    list.addAll(focusOnObjects);
    var builder = FocusOnGravityBuilder(list);
    if (options != null) {
      builder.copyWith(options);
    }
    return builder.build();
  }
}

class CompassGravity extends Gravity {
  Compass compass;

  CompassGravity(this.compass);

  @override
  String toString() {
    return compass.toString();
  }
}

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

class FocusOnGravity extends Gravity {
  List<FocusOn> focusOnObjects;
  AutoGravity? fallbackGravity;

  FocusOnGravity(this.focusOnObjects, this.fallbackGravity);

  @override
  String toString() {
    return focusOnObjects.join(":").joinWithValues([fallbackGravity.toString()]);
  }
}

class FocusOnGravityBuilder implements GeneralBuilder {
  List<FocusOn> objects;
  AutoGravity? _fallbackGravity;

  FocusOnGravityBuilder(this.objects);

  FocusOnGravityBuilder fallbackGravity(AutoGravity graviy) {
    _fallbackGravity = graviy;
    return this;
  }

  FocusOnGravity build() {
    return FocusOnGravity(objects, _fallbackGravity);
  }

  @override
  void copyWith(other) {
    objects = other.objects;
    _fallbackGravity = other._fallbackGravity;
  }
}

class AutoGravity extends Gravity {

  List<IAutoGravityObject> objects;

  AutoGravity(this.objects);

  @override
  String toString() {
    return "auto".joinWithValues(objects);
  }
}

class AutoGravityBuilder {
  List<IAutoGravityObject> objects = [];

  AutoGravityBuilder autoFocusOn(List<IAutoGravityObject> objects) {
    this.objects.addAll(objects);
    return this;
  }

  build() {
    return AutoGravity(objects);
  }
}

class AutoFocus {
  static AutoGravityObject focusOn(FocusOn focus, {IAutoGravityObjectBuilder? options}) {
    var builder = IAutoGravityObjectBuilder(focus);
    options ?? builder.copyWith(options);
    return builder.build();
  }
}

class AutoGravityObject implements IAutoGravityObject {
  IGravityObject gravityObject;
  int? weight;
  bool? avoid;

  AutoGravityObject(this.gravityObject, {this.weight, this.avoid});

  @override
  String toString() {
    var weightStr = (avoid != null && avoid == true) ? "avoid" : weight.toString();
    return '$gravityObject'.joinWithValues([weightStr], separator: "_");
  }
}

abstract class IAutoGravityObject {

}

class IAutoGravityObjectBuilder implements GeneralBuilder {
  FocusOn focusOn;
  int? _weight;
  bool? _avoid;

  IAutoGravityObjectBuilder(this.focusOn);

  IAutoGravityObjectBuilder weight(int weight) {
    _weight = weight;
    return this;
  }

  IAutoGravityObjectBuilder avoid() {
    _avoid = true;
    return this;
  }

  AutoGravityObject build() {
    return AutoGravityObject(focusOn, weight: _weight, avoid: _avoid);
  }

  @override
  void copyWith(other) {
    focusOn = other.focusOn;
    _weight = other._weight;
    _avoid = other._avoid;
  }
}

abstract class IGravityObject {

}
