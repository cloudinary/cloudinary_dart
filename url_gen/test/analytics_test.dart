import 'package:test/test.dart';

import 'package:cloudinary_url_gen/analytics.dart';

import 'tests_utils.dart';

void main() {
  group('Analytics Tests', () {
    test('Should successfully generate analytics string', () {
      var analytics =
          Analytics.fromParameters("1.24.0", "12.0").generateAnalyticsString();
      cldAssert("AOAlhAM0", analytics);
    });
    test('Should successfully generate analytics string', () {
      var analytics = Analytics.fromParameters("1.24.0-beta.6", "12.0")
          .generateAnalyticsString();
      cldAssert("AOAlhAM0", analytics);
    });
  });
}
