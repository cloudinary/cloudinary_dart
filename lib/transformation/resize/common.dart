/// Class Aspect Ratio
class AspectRatio {
  String value;

  AspectRatio(this.value);

  static final _ar1X1 = AspectRatio("1:1");
  static final _ar5X4 = AspectRatio("5:4");
  static final _ar4X3 = AspectRatio("4:3");
  static final _ar3X2 = AspectRatio("3:2");
  static final _ar16X9 = AspectRatio("16:9");
  static final _ar3X1 = AspectRatio("3:1");
  static final ignoreInitialAspectRatio = AspectRatio("fl_ignore_aspect_ratio");

  static AspectRatio ar1X1() => _ar1X1;
  static AspectRatio ar5X4() => _ar5X4;
  static AspectRatio ar4X3() => _ar4X3;
  static AspectRatio ar3X2() => _ar3X2;
  static AspectRatio ar16X9() => _ar16X9;
  static AspectRatio ar3X1() => _ar3X1;
  static AspectRatio setIgnoreInitialAspectRatio() => ignoreInitialAspectRatio;

  @override
  String toString() {
    return value;
  }
}