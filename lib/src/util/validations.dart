extension IntValidation on int? {
  int? cldRange([int? min, int? max]) {
    if (this != null) {
      if ((min != null && this! < min) || (max != null && this! > max)) {
        throw ArgumentError('$this is not in range ($min-$max');
      }
    }
    return this;
  }
}
