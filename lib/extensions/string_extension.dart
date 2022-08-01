extension stringManipulation on String {

  String toAnalyticsString() {
    var num = int.parse(this,radix: 2);
    if (num != null) {
      if (num >= 0 && num <= 25) {
        return String.fromCharCode('A'.codeUnitAt(0) + num);
      } else if (num >= 26 && num <= 51) {
        return String.fromCharCode('a'.codeUnitAt(0) + num - 26);
      } else {
        return String.fromCharCode('0'.codeUnitAt(0) + num - 52);
      }
    }
    return "";
  }
}