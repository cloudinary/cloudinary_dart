import 'dart:io';

class PlatformWrapper {
  static final bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

  static String getOperatingSystemVersion() {
    if(!kIsWeb) {
      return Platform.operatingSystemVersion;
    }
    return "";
  }

  static String getVersion() {
    if(!kIsWeb) {
      return Platform.version.split(" ")[0];
    } else {
      return "";
    }
  }

  static bool isiOS() {
    if(!kIsWeb) {
      return Platform.isIOS;
    }
    return false;
  }

  static bool isAndroid() {
    if(!kIsWeb) {
      return Platform.isAndroid;
    }
    return false;
  }
}