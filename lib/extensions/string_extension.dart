import 'dart:ffi';

extension StringManipulations on String? {
  bool get isNullOrBlank => (this == null) ? true : this!.trim()?.isEmpty ?? true;
}

extension StringManipulation on String {
  String toAnalyticsString() {
    int num = int.parse(this, radix: 2);
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

  bool get isBlank => trim()?.isEmpty ?? true;

  bool get isNotNullAndNotEmpty => this != null && isNotEmpty;

  bool get cldIsHttpUrl =>
      toLowerCase().startsWith("https:/") || toLowerCase().startsWith("http:/");

  String cldMergeSlashedInUrl() {
    StringBuffer builder = StringBuffer();
    bool prevIsColon = false;
    bool inMerge = false;

    for (int i = 0; i < length; i++) {
      var c = this[i];
      if (c == ':') {
        prevIsColon = true;
        builder.write(c);
      } else {
        if (c == '/') {
          if (prevIsColon) {
            builder.write(c);
            inMerge = false;
          } else {
            if (!inMerge) {
              builder.write(c);
            }
            inMerge = true;
          }
        } else {
          inMerge = false;
          builder.write(c);
        }
        prevIsColon = false;
      }
    }
    return builder.toString();
  }

  String cldSmartUrlEncode() {
    return Uri.encodeComponent(this)
        .replaceAll("%2F", "/")
        .replaceAll("%3A", ":")
        .replaceAll("+", "%20");
  }

  bool cldHasVersionString() {
    var inVersion = false;
    for (int i = 0; i < length; i++) {
      var c = this[i];
      if (c == 'v') {
        inVersion = true;
      } else if (isDigit(c, 0) && inVersion) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  bool isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;

  String cldRemoveStartingChars(String c) {
    var lastToRemove = -1;
    for (int i = 0; i < length; i++) {
      if (this[i] == c) {
        lastToRemove = i;
        continue;
      }
      if(this[i] != c) {
        break;
      }
    }
    return (lastToRemove < 0) ? this : substring(lastToRemove + 1);
  }
}
