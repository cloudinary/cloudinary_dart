import 'dart:convert';
import 'dart:math';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class Utils {
  static List<String> _excludeKeys = const [
    'resource_type',
    'unsigned',
    'filename',
  ];

  static String apiSignRequest(Map<String, dynamic> paramsMap, String apiSecret, int signatureVersion) {
    paramsMap.removeWhere((key, value) => value == null || _excludeKeys.contains(key));

    String queryString = (paramsMap.keys.whereType<String>().toList()..sort())
        .where((key) => paramsMap[key] is List<String> ? (paramsMap[key] as List<String>).isNotEmpty : paramsMap[key] != null)
        .map((key) {
      var value = paramsMap[key].toString().replaceAll(r'\', '');
      if (signatureVersion == 2) {
        value = value.replaceAll('&', '%26');
      }
      return '$key=$value';
    }).join('&');
    return hex.encode(sha1.convert(utf8.encode(queryString + apiSecret)).bytes);
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

enum ContextCommand { add, remove_all }
