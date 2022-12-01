import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

const String keyKey = "key";
const String ipKey = "ip";
const String aclKey = "acl";
const String startTimeKey = "start_time";
const String expirationKey = "expiration";
const String durationKey = "duration";

var nullAutoToken = AuthToken.fromParameters("", isNullableToken: true);
const String _authTokenName = "__cld_token__";

class AuthToken {
  String? _tokenName = _authTokenName;
  String? _key = "";
  int startTime = 0;
  int _expiration = 0;
  String? ip;
  String? acl;
  int _duration = 0;
  bool _isNullToken = false;

  bool get isNullToken => _isNullToken;

  int get duration => _duration;

  int get expiration => _expiration;

  String? get key => _key;

  String? get tokenName => _tokenName;

  AuthToken.fromParameters(String key,
      {this.startTime = 0,
      int duration = 0,
      String? tokenName,
      int expiration = 0,
      this.ip,
      this.acl,
      bool isNullableToken = false}) {
    _key = key;
    _expiration = expiration;
    _duration = duration;
    _tokenName = tokenName ?? _authTokenName;
    _isNullToken = isNullableToken;
  }

  AuthToken.fromMap(Map<String, dynamic> params) {
    _key = params[keyKey];
    startTime = int.parse(params[startTimeKey] ?? "0");
    _expiration = int.parse(params[expirationKey] ?? "0");
    ip = params[ipKey];
    acl = params[aclKey];
    _duration = int.parse(params[durationKey] ?? "0");
  }

  String digest(String message) {
    var binKey = hex.decode(_key!);
    var dataBytes = Utf8Encoder().convert(message);
    var hmacBytes = Hmac(sha256, binKey).convert(dataBytes).bytes;
    return hex.encode(hmacBytes).toLowerCase();
  }

  String generate([String? url]) {
    var start = 0;
    var expiration = _expiration;
    if (_expiration == 0) {
      if (_duration > 0) {
        if (startTime > 0) {
          start = startTime;
        } else {
          start =
              (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).round();
        }
        expiration = start + _duration;
      } else {
        throw ArgumentError('Must provide either expiration or duration');
      }
    }
    List tokenParts = <String>[];
    if (ip != null) {
      tokenParts.add('ip=$ip');
    }
    if (startTime > 0) {
      tokenParts.add('st=$startTime');
    }
    tokenParts.add('exp=$expiration');
    if (acl != null) {
      var uri = Uri.encodeComponent(acl!).toLowerCase();
      tokenParts.add('acl=$uri'); // need to encode this String
    }
    var toSign = tokenParts;
    if (url != null && acl == null) {
      toSign.add('url=$url');
    }
    var auth = digest(toSign.join("~"));
    tokenParts.add("hmac=$auth");
    return "${_tokenName!}=${tokenParts.join("~")}";
  }
}
