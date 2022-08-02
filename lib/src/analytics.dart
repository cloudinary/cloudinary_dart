
import 'dart:io';

import 'package:cloudinary_dart/extensions/string_extension.dart';

class Analytics {
  final sdkTokenQueryKey = "_a";
  final sdkQueryDelimiter = "=";
  final algoVersion = 'A';
  String sdkVersion = "0.0.1";
  final sdk = 'O';
  final errorSignature = "E";
  final noFeatureChar = '0';
  String techVersion = "";

  Analytics() {
    techVersion = Platform.version.split(" ")[0];
  }

  Analytics.withParameters(this.sdkVersion, this.techVersion);

  String generateAnalyticsString() {
    try {
      return '$algoVersion$sdk${getVersionString(sdkVersion)}${getVersionString(
          techVersion)}$noFeatureChar';
    } catch(e) {
      return errorSignature;
    }
  }

  String getVersionString(String version) {
    var techVersionArray = version.split(RegExp(r'\.|\-'));
    return generateVersionString(techVersionArray);
  }


  String generateVersionString(List<String> versionArray) {
    var major = versionArray[0];
    var minor = versionArray[1];
    String? patch;
    if (versionArray.length > 2) {
      patch = versionArray[2];
    } else {
      patch = "";
    }
    var versionString = patch!.padLeft(2,"0") + minor.padLeft(2, "0") + major.padLeft(2, "0");
    var version = int.parse(versionString).toRadixString(2).padLeft(18, "0");

    var patchStr = "";
    if(patch.isNotEmpty) { patchStr = version.substring(0, 6).toAnalyticsString();}
    var minorStr = version.substring(6,12).toAnalyticsString();
    var majorStr = version.substring(12,18).toAnalyticsString();

    return '$patchStr$minorStr$majorStr';
  }
}
