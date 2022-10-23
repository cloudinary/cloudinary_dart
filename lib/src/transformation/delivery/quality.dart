class QualityValue {
  List<String> values;

  /// Sets the quality level [values](Range 1 to 100).
  QualityValue(this.values);

  /// Quality auto
  static QualityValue auto() {
    return QualityValue(["auto"]);
  }

  /// Quality eco
  static QualityValue autoEco() {
    return QualityValue(["auto", "eco"]);
  }

  /// Quality good
  static QualityValue autoGood() {
    return QualityValue(["auto", "good"]);
  }

  /// Quality best
  static QualityValue autoBest() {
    return QualityValue(["auto", "best"]);
  }

  /// Quality low
  static QualityValue autoLow() {
    return QualityValue(["auto", "low"]);
  }

  /// Quality jpegmini
  static QualityValue jpegmini() {
    return QualityValue(["jpegmini"]);
  }

  /// Quality jpegminiHigh
  static QualityValue jpegminiHigh() {
    return QualityValue(["jpegmini", "1"]);
  }

  /// Quality jpegminiMedium
  static QualityValue jpegminiMedium() {
    return QualityValue(["jpegmini", "2"]);
  }

  /// Quality jpegminiBest
  static QualityValue jpegminiBest() {
    return QualityValue(["jpegmini", "0"]);
  }

  /// Returns [QualityValue] as string connected with ':'
  @override
  String toString() {
    return values.join(":");
  }
}
