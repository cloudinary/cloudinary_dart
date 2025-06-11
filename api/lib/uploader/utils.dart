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

  static String apiSignRequest(Map<String, dynamic> paramsMap, String apiSecret) {
    final escapePattern = RegExp(r'[&=%+#]');
    final paramsArr = <String>[];

    paramsMap.removeWhere((key, value) => value == null || _excludeKeys.contains(key));

    if (paramsMap.containsKey('public_id')) {
      final publicId = paramsMap['public_id'].toString();
      if (escapePattern.hasMatch(publicId)) {
        return '';
      }
    }

    final sortedKeys = paramsMap.keys.whereType<String>().toList()..sort();

    for (final key in sortedKeys) {
      final value = paramsMap[key];
      String? paramValue;

      if (value is List) {
        if (value.isEmpty) continue;
        paramValue = value.join(',');
      } else {
        paramValue = value?.toString();
      }

      if (paramValue != null) {
        paramsArr.add('$key=$paramValue');
      }
    }

    final toSign = '${paramsArr.join('&')}$apiSecret';
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

enum ContextCommand { add, remove_all }
