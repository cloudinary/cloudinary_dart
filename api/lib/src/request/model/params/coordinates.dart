class Coordinates {
  late List<Rectangle> coordinates;

  Coordinates(this.coordinates);

  Coordinates.withString(String stringCoords) {
    coordinates = _parseString(stringCoords);
  }

  factory Coordinates.fromJson(List<dynamic> data) {
    List<Rectangle> coordinates = <Rectangle>[];
    for (List<dynamic> item in data) {
      coordinates.addAll(_parseString(item.join(",")));
    }
    return Coordinates(coordinates);
  }
}

List<Rectangle> _parseString(String stringCoords) {
  List<Rectangle> coordinates = <Rectangle>[];
  for (String stringRect in stringCoords.split('|').toList()) {
    if (stringRect.isEmpty) {
      continue;
    }
    var elements = stringRect.split(',').toList();
    if (elements.length != 4) {
      throw ArgumentError(
          'Must supply exactly 4 values for coordinates (x,y,width,height) ${elements.length} supplied: $stringRect');
    }
    coordinates.add(Rectangle(
        double.parse(elements[0]).round(),
        double.parse(elements[1]).round(),
        double.parse(elements[2]).round(),
        double.parse(elements[3]).round()));
  }
  return coordinates;
}

class Rectangle {
  int x;
  int y;
  int width;
  int height;

  Rectangle(this.x, this.y, this.width, this.height);

  @override
  bool operator ==(Object other) {
    if (other is! Rectangle) return false;
    if (x != other.x) return false;
    if (y != other.y) return false;
    if (width != other.width) return false;
    if (height != other.height) return false;
    return true;
  }

  @override
  int get hashCode =>
      x.hashCode + y.hashCode + width.hashCode + height.hashCode;
}
