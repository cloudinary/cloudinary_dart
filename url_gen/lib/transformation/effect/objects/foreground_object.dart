class ForegroundObject {
  String value;

  ForegroundObject(this.value);

  static ForegroundObject airplane() => ForegroundObject('airplane');
  static ForegroundObject bus() => ForegroundObject('bus');
  static ForegroundObject diningTable() => ForegroundObject('dining_table');
  static ForegroundObject sheep() => ForegroundObject('sheep');
  static ForegroundObject bicycle() => ForegroundObject('bicycle');
  static ForegroundObject car() => ForegroundObject('car');
  static ForegroundObject dog() => ForegroundObject('dog');
  static ForegroundObject sofa() => ForegroundObject('sofa');
  static ForegroundObject bird() => ForegroundObject('bird');
  static ForegroundObject cat() => ForegroundObject('cat');
  static ForegroundObject horse() => ForegroundObject('horse');
  static ForegroundObject train() => ForegroundObject('train');
  static ForegroundObject boat() => ForegroundObject('boat');
  static ForegroundObject chair() => ForegroundObject('chair');
  static ForegroundObject person() => ForegroundObject('person');
  static ForegroundObject tv() => ForegroundObject('tv');
  static ForegroundObject bottle() => ForegroundObject('bottle');
  static ForegroundObject cow() => ForegroundObject('cow');
  static ForegroundObject pottedPlanet() => ForegroundObject('potted_plant');
  static ForegroundObject motorbike() => ForegroundObject('motorbike');

  @override
  String toString() {
    return value;
  }
}