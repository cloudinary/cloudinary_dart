import 'dart:io';

class PlatformWrapper {

  static bool? kIsWeb;

  static bool isWeb() {
    if (kIsWeb != null) {
      return kIsWeb!;
    }
      try {
        kIsWeb = bool.fromEnvironment('dart.library.js_util');
      } catch (e) {
        kIsWeb = false;
      }
    return kIsWeb!;
  }

  static String getOperatingSystemVersion() {
    if(!isWeb()) {
      try {
        return Platform.operatingSystemVersion;
      } catch (e) {
        return '0';
      }
    }
    return '';
  }

  static String getVersion() {
    if(!isWeb()) {
      try {
        return Platform.version.split(" ")[0];
      } catch(e) {
        return '0';
      }
    }
    return '';
  }

  static bool isiOS() {
    if(!isWeb()) {
      try {
        return Platform.isIOS;
      } catch(e) {
        return false;
      }
    }
    return false;
  }

  static bool isAndroid() {
    if(!isWeb()) {
      try {
        return Platform.isAndroid;
      } catch (e) {
        return false;
      }
    }
    return false;
  }
}