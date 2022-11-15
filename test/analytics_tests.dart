import 'package:cloudinary_dart/analytics.dart';
import 'package:test/test.dart';

void main() {
  group('Analytics Tests', () {
    test('Should successfully generate analytics string', () {
      var analytics =
          Analytics.fromParameters("1.24.0", "12.0").generateAnalyticsString();
      assert("AOAlhAM0" == analytics);
    });
    test('Should successfully generate analytics string', () {
      var analytics = Analytics.fromParameters("1.24.0-beta.6", "12.0")
          .generateAnalyticsString();
      assert("AOAlhAM0" == analytics);
    });
  });
}
