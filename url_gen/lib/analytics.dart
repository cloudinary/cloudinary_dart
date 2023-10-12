import 'package:universal_io/io.dart';

import 'cloudinary.dart';
import 'src/extensions/string_extension.dart';

class Analytics {
  final sdkTokenQueryKey = "_a";
  final sdkQueryDelimiter = "=";
  final algoVersion = 'C';
  final product = 'A';
  String sdk = 'O';
  final errorSignature = "E";
  final noFeatureChar = '0';
  String techVersion = "";
  String osType = 'Z'; // Z stand for 'other'
  String osVersion = '';

  Analytics() {
    techVersion = Platform.version.split(" ")[0];
  }

  Analytics.fromParameters(version, this.techVersion, this.osVersion) {
    sdkVersion = version;
  }

  String generateAnalyticsString() {
    getOSPlatform();
    try {
      return '$algoVersion$product$sdk${getVersionString(sdkVersion, shouldUsePatch: true)}${getVersionString(techVersion)}$osType${getOsVersion()}$noFeatureChar';
    } catch (e) {
      return errorSignature;
    }
  }

  String getVersionString(String version, {bool shouldUsePatch = false}) {
    var versionArray =
        getVersionArray(version); //version.split(RegExp(r'[.\-]'));
    if (shouldUsePatch) {
      return generateVersionString(versionArray);
    }
    return generateVersionString([versionArray[0], versionArray[1]]);
  }

  List<String> getVersionArray(String versionString) {
    RegExp versionRegex = RegExp(r'(?:Version )?(\d+(?:\.\d+){0,2})');
    Match? match = versionRegex.firstMatch(versionString);

    List<String> versionArray = [];

    if (match != null) {
      String versionNumber = match.group(1)!;
      versionArray = versionNumber.split('.').toList();
    }
    return versionArray;
  }

  String generateVersionString(List<String> versionArray) {
    var major = versionArray[0];
    var minor = versionArray[1];
    String patch;
    if (versionArray.length > 2) {
      patch = versionArray[2];
    } else {
      patch = "";
    }
    var versionString =
        patch.padLeft(2, "0") + minor.padLeft(2, "0") + major.padLeft(2, "0");
    var version = int.parse(versionString).toRadixString(2).padLeft(18, "0");

    var patchStr = "";
    if (patch.isNotEmpty) {
      patchStr = version.substring(0, 6).toAnalyticsString();
    }
    var minorStr = version.substring(6, 12).toAnalyticsString();
    var majorStr = version.substring(12, 18).toAnalyticsString();

    return '$patchStr$minorStr$majorStr';
  }

  String getOsVersion() {
    try {
      return getVersionString(osVersion);
    } catch (e) {
      return 'AA'; // AA stands for not found.
    }
  }

  void getOSPlatform() {
    if (Platform.isIOS) {
      osType = 'B'; // 'B' stands for iOS
      osVersion = getVersionString(Platform.operatingSystemVersion);
    } else if (Platform.isAndroid) {
      osType = 'A'; // 'A' stands for Android
      osVersion = getVersionString(Platform.operatingSystemVersion);
    } else {
      osType = 'Z'; // Z stands for other
    }
  }
}
