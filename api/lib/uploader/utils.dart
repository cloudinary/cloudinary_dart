import 'dart:convert';
import 'dart:math';

import 'package:cloudinary_url_gen/transformation/coordinates/coordinates.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

import '../src/request/model/params/access_control_rule.dart';
import '../src/request/model/params/eager_transformation.dart';
import '../src/request/model/params/responsive_breakpoint.dart';

class Utils {
  static String apiSignRequest(
      Map<String, dynamic> paramsMap, String apiSecret) {
    List<String> paramsArr = <String>[];
    paramsMap.removeWhere((key, value) => value == null);
    var sortedParams = paramsMap.keys.whereType<String>().toList()..sort();
    for (var key in sortedParams) {
      var value = paramsMap[key];
      String? paramValue;
      if (value is List<String>) {
        if (value.isNotEmpty) {
          paramValue = value.toString(); //.join(',');
        } else {
          continue;
        }
      } else {
        if (value != null) {
          paramValue = value.toString();
        }
      }
      if (paramValue != null) {
        paramsArr.add('$key=${paramValue.replaceAll(r'\', '')}');
      }
    }
    var toSign = '${paramsArr.join('&')}$apiSecret';
    return hex.encode(sha1.convert(utf8.encode(toSign)).bytes);
  }

  static bool isRemoteUrl(String value) {
    return RegExp(
            r'ftp:.*|https?:.*|s3:.*|gs:.*|data:([\w-]+/[\w-]+)?(;[\w-]+=[\w-]+)*;base64,([a-zA-Z0-9/+ =]+)')
        .hasMatch(value);
  }

  static final Random _random = Random();

  static String createRandomUploadId(int length) {
    StringBuffer sb = StringBuffer();
    for (var i = 0; i < length; i++) {
      sb.write(_random.nextInt(16).toRadixString(16));
    }
    return sb.toString();
  }

  static final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


}
enum ContextCommand{add, remove_all}
