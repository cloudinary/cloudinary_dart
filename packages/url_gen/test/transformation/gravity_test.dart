import 'package:test/scaffolding.dart';

import '../../lib/transformation/gravity/focus_on.dart';
import '../../lib/transformation/gravity/gravity.dart';
import '../tests_utils.dart';

void main() {
  test('Test successful gravity formatting', () {
    cldAssert("cat:bird", Gravity.focusOn([FocusOn.cat(), FocusOn.bird()]));
    cldAssert(
        "cat:bird:auto:microwave_30:bottle_avoid",
        Gravity.focusOn([FocusOn.cat(), FocusOn.bird()])
          ..fallbackGravity(Gravity.autoGravity(
              [FocusOn.microwave().weight(30), FocusOn.bottle().avoid()])));
    cldAssert("west", Gravity.west());
  });
  test('Test successful auto gravity formatting', () {
    cldAssert("auto", Gravity.autoGravity());
    cldAssert("auto:face", Gravity.autoGravity([FocusOn.face()]));
    cldAssert("auto:cat", Gravity.autoGravity([FocusOn.cat()]));
    cldAssert(
        "auto:cat:dog", Gravity.autoGravity([FocusOn.cat(), FocusOn.dog()]));
    cldAssert(
        "auto:cat_30:dog_avoid:bird",
        Gravity.autoGravity(
            [FocusOn.cat().weight(30), FocusOn.dog().avoid(), FocusOn.bird()]));
    cldAssert(
        "auto:cat_30:dog_avoid",
        Gravity.autoGravity([FocusOn.cat().weight(30)])
          ..autoFocusOn([FocusOn.dog().avoid()]));
  });
}
