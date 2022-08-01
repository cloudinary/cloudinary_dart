
import 'package:cloudinary_dart/src/Analytics.dart';
import 'package:test/test.dart';

void main() {
  group('Analytics Tests', () {
    test('Should successfully generate analytics string', () {
        var analytics = Analytics.withParameters("1.24.0", "12.0").generateAnalyticsString();
        assert("AOAlhAM0" == analytics);
    });
    test('Should successfully generate analytics string', () {
      var analytics = Analytics.withParameters("1.24.0-beta.6", "12.0").generateAnalyticsString();
      assert("AOAlhAM0" == analytics);
    });
  });
}