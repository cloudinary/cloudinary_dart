import 'package:test/test.dart';

import 'package:cloudinary_url_gen/analytics.dart';

import 'tests_utils.dart';

void main() {
  group('Analytics Tests', () {
    test('Should successfully generate analytics string', () {
      var analytics =
          Analytics.fromParameters("1.24.0", "12.0", "17.0").generateAnalyticsString();
      cldAssert("CAOAlhAMZAR0", analytics);
    });
    test('Should successfully generate analytics string', () {
      var analytics = Analytics.fromParameters("1.24.0-beta.6", "12.0", "17.0")
          .generateAnalyticsString();
      cldAssert("CAOAlhAMZAR0", analytics);
    });
    test(
        'Test sucessfully generate analytics string with patch for tech version',
        () {
      var analytics = Analytics.fromParameters("1.24.0", "12.0.1", "17.0")
          .generateAnalyticsString();
      cldAssert("CAOAlhAMZAR0", analytics);
    });
  });
}
