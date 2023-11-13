import 'package:test/test.dart';

import 'package:cloudinary_url_gen/analytics.dart';

import 'tests_utils.dart';

void main() {
  group('Analytics Tests', () {
    test('Should successfully generate analytics string', () {
      var analytics = Analytics.fromParameters('R', '1.24.0', '12.0', '17.0')
          .generateAnalyticsString();
      cldAssert('CARAlhAMZAR0', analytics);
    });
    test('Should successfully generate analytics string', () {
      var analytics =
          Analytics.fromParameters('R', '1.24.0-beta.6', '12.0', '17.0')
              .generateAnalyticsString();
      cldAssert('CARAlhAMZAR0', analytics);
    });
    test(
        'Test sucessfully generate analytics string with patch for tech version',
        () {
      var analytics = Analytics.fromParameters('R', '1.24.0', '12.0.1', '17.0')
          .generateAnalyticsString();
      cldAssert('CARAlhAMZAR0', analytics);
    });
    test('Test successfully generate analytics token with misbehaved version string', () {
            var analytics = Analytics.fromParameters('R', '1.24.0', '12.0.1', 'sdk_gphone64_arm64-userdebug 13 TE1A.220922.031 10278734 dev-keys')
                .generateAnalyticsString();
            cldAssert('CARAlhAMZAA0', analytics);
    });
  });
}
