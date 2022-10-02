class Quality {

  List<String> values;

  /// Sets the quality level [values](Range 1 to 100).
  Quality(this.values);

  /// Quality auto
  static Quality auto() {
    return Quality(["auto"]);
  }

  /// Quality eco
  static Quality autoEco() {
    return Quality(["auto", "eco"]);
  }

  /// Quality good
  static autoGood() {
    return Quality(["auto", "good"]);
  }

  /// Quality best
  static autoBest() {
    return Quality(["auto", "best"]);
  }

  /// Quality low
  static autoLow() {
    return Quality(["auto", "low"]);
  }

  /// Quality jpegmini
  static jpegmini() {
    return Quality(["jpegmini"]);
  }

  /// Quality jpegminiHigh
  static jpegminiHigh() {
    return Quality(["jpegmini", "1"]);
  }

  /// Quality jpegminiMedium
  static jpegminiMedium() {
    return Quality(["jpegmini", "2"]);
  }

  /// Quality jpegminiBest
  static jpegminiBest() {
    return Quality(["jpegmini", "0"]);
  }

  /// Returns [Quality] as string connected with ':'
  @override
  String toString() {
    return values.join(":");
  }
}