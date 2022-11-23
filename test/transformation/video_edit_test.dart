import 'package:cloudinary_dart/transformation/video_edit/video_edit.dart';
import 'package:cloudinary_dart/transformation/video_edit/video_edit_actions.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful video edit trim formatting', () {
    cldAssert("so_2.63", VideoEdit.trim().startOffset(2.63));
    cldAssert("so_35.0p", VideoEdit.trim().startOffset("35.0p"));

    cldAssert("eo_auto", VideoEdit.trim().endOffset("auto"));
    cldAssert("eo_2.63", VideoEdit.trim().endOffset(2.63));
    cldAssert("eo_35.0p", VideoEdit.trim().endOffset("35.0p"));
    //TODO: Expression support
    // cldAssert("so_du_div_3", VideoEdit.trim {
    // startOffset(Expression("duration / 3")))
    // cldAssert("eo_du_div_3", VideoEdit.trim {
    // endOffset(Expression("duration / 3"))
    // })
    cldAssert("du_2.63", VideoEdit.trim().duration(2.63));
    cldAssert("du_35.0p", VideoEdit.trim().duration("35.0p"));

    cldAssert("du_2.63,so_3.0", VideoEdit.trim().startOffset(3.0).duration(2.63));
    cldAssert("du_35.0p,so_auto", VideoEdit.trim().startOffset("auto").duration("35.0p"));
  });
  test('Test successful video edit volume formatting', () {
    cldAssert("e_volume:50", VideoEdit.volume(50));
    cldAssert("e_volume:50", VideoEdit.volume(Volume.byPercent(50)));
    cldAssert("e_volume:10db", VideoEdit.volume(Volume.byDecibels(10)));
    cldAssert("e_volume:mute", VideoEdit.volume(Volume.mute()));
  });
}