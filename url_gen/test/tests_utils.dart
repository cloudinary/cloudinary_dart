import 'dart:io';

import '../lib/auth_token.dart';

class TestUtils {
  static bool compareAuthToken(AuthToken? first, AuthToken? second) {
    if (first != null && second != null) {
      if (first.tokenName != second.tokenName) return false;
      if (first.key != second.key) return false;
      if (first.startTime != second.startTime) return false;
      if (first.expiration != second.expiration) return false;
      if (first.ip != second.ip) return false;
      if (first.acl != second.acl) return false;
      if (first.duration != second.duration) return false;
      if (first.isNullToken != second.isNullToken) return false;
      return true;
    }
    return false;
  }
}

void cldAssert(String expected, dynamic actual) {
  if (expected != actual.toString()) {
    stderr.writeln("expected: $expected");
    stderr.writeln("actual  : $actual");
  }
  assert(expected == actual.toString());
}
