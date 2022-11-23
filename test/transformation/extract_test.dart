import 'package:cloudinary_dart/transformation/extract/extract.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful extract get frame formatting', () {
    cldAssert("pg_3", Extract.getFrame().byNumber(3));
    cldAssert("pg_1-3", Extract.getFrame().byRange(1, 3));
    cldAssert("pg_1-3;5;7-",
        Extract.getFrame().byRange(1, 3).byNumber(5).byRange(7, null));
  });

  test('Test successful extract get page formatting', () {
    cldAssert("pg_3", Extract.getPage().byNumber(3));
    cldAssert("pg_1-3", Extract.getPage().byRange(1, 3));
    cldAssert("pg_1-3;5;7-",
        Extract.getPage().byRange(1, 3).byNumber(5).byRange(7, null));
  });
}
