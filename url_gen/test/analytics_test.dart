import 'package:test/test.dart';

import 'package:cloudinary_url_gen/analytics/analytics.dart';

import 'tests_utils.dart';

void main() {
  group('Analytics Tests', () {
    test('Should successfully generate analytics string', () {
      var analytics = Analytics.fromParameters(sdk: 'R', version: '1.24.0', techVersion: '12.0', osType: 'Z', osVersion: '17.0')
          .generateAnalyticsString();
      cldAssert('DARAlhAMZRA0', analytics);
    });
    test('Should successfully generate analytics string', () {
      var analytics =
          Analytics.fromParameters(sdk: 'R', version: '1.24.0-beta.6', techVersion: '12.0', osType: 'Z', osVersion: '17.0')
              .generateAnalyticsString();
      cldAssert('DARAlhAMZRA0', analytics);
    });
    test(
        'Test sucessfully generate analytics string with patch for tech version',
        () {
      var analytics = Analytics.fromParameters(sdk: 'R', version: '1.24.0', techVersion: '12.0.1', osType: 'Z', osVersion: '17.0')
          .generateAnalyticsString();
      cldAssert('DARAlhAMZRA0', analytics);
    });
    test('Test successfully generate analytics token with misbehaved version string', () {
            var analytics = Analytics.fromParameters(sdk: 'R', version: '1.24.0', techVersion: '12.0.1', osType: 'Z', osVersion: 'sdk_gphone64_arm64-userdebug 13 TE1A.220922.031 10278734 dev-keys')
                .generateAnalyticsString();
            cldAssert('DARAlhAMZAA0', analytics);
    });
  });
}
