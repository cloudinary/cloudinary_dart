class Coordinates {
  late List<Rectangle> coordinates;

  Coordinates(this.coordinates);

  Coordinates.withString(String stringCoords) {
    coordinates = _parseString(stringCoords);
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
    coordinates.add(Rectangle(int.parse(elements[0]), int.parse(elements[1]),
        int.parse(elements[2]), int.parse(elements[3])));
  }
  return coordinates;
}

class Rectangle {
  int x;
  int y;
  int width;
  int height;

  Rectangle(this.x, this.y, this.width, this.height);
}
