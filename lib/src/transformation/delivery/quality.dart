class Quality {

  List<String> values;

  Quality(this.values);

  static Quality auto() {
    return Quality(["auto"]);
  }

  static Quality autoEco() {
    return Quality(["auto", "eco"]);
  }

  static autoGood() {
    return Quality(["auto", "good"]);
  }

  static autoBest() {
    return Quality(["auto", "best"]);
  }

  static autoLow() {
    return Quality(["auto", "low"]);
  }

  static jpegmini() {
    return Quality(["jpegmini"]);
  }

  static jpegminiHigh() {
    return Quality(["jpegmini", "1"]);
  }

  static jpegminiMedium() {
    return Quality(["jpegmini", "2"]);
  }

  static jpegminiBest() {
    return Quality(["jpegmini", "0"]);
  }

  @override
  String toString() {
    return values.join(":");
  }
}