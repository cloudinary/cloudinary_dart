import 'dart:io';

import 'cloudinary.dart';
import 'src/extensions/string_extension.dart';

class Analytics {
  final sdkTokenQueryKey = "_a";
  final sdkQueryDelimiter = "=";
  final algoVersion = 'A';
  final sdk = 'O';
  final errorSignature = "E";
  final noFeatureChar = '0';
  String techVersion = "";

  Analytics() {
    techVersion = Platform.version.split(" ")[0];
  }

  Analytics.fromParameters(version, this.techVersion) {
    sdkVersion = version;
  }

  String generateAnalyticsString() {
    try {
      return '$algoVersion$sdk${getVersionString(sdkVersion, shouldUsePatch: true)}${getVersionString(techVersion)}$noFeatureChar';
    } catch (e) {
      return errorSignature;
    }
  }

  String getVersionString(String version, {bool shouldUsePatch = false}) {
    var versionArray = version.split(RegExp(r'[.\-]'));
    if (shouldUsePatch) {
      return generateVersionString(versionArray);
    }
    return generateVersionString([versionArray[0], versionArray[1]]);
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
}
