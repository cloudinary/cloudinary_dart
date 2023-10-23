import 'package:cloudinary_url_gen/transformation/color.dart';
import 'package:cloudinary_url_gen/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_url_gen/transformation/video_edit/video_edit.dart';
import 'package:cloudinary_url_gen/transformation/video_edit/video_edit_actions.dart';
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

    cldAssert(
        "du_2.63,so_3.0", VideoEdit.trim().startOffset(3.0).duration(2.63));
    cldAssert("du_35.0p,so_auto",
        VideoEdit.trim().startOffset("auto").duration("35.0p"));
  });
  test('Test successful video edit volume formatting', () {
    cldAssert("e_volume:50", VideoEdit.volume(50));
    cldAssert("e_volume:50", VideoEdit.volume(Volume.byPercent(50)));
    cldAssert("e_volume:10db", VideoEdit.volume(Volume.byDecibels(10)));
    cldAssert("e_volume:mute", VideoEdit.volume(Volume.mute()));
  });
  test('Test successful video edit preview formatting', () {
    cldAssert(
        "e_preview:duration_12.0:max_seg_3:min_seg_dur_3",
        VideoEdit.preview()
            .duration(12)
            .maximumSegments(3)
            .minimumSegmentDuration(3));
  });
  test('Test successful video edit waveform formatting', () {
    cldAssert("f_jpg,fl_waveform", VideoEdit.waveform(Format(Format.jpg)));
    cldAssert(
        "b_white,co_black,f_png,fl_waveform",
        VideoEdit.waveform(Format(Format.png))
            .color(Color.black())
            .background(Color.white()));
  });
  test('Test successful video edit progressbar formatting', () {
    cldAssert("e_progressbar", VideoEdit.progressBar());
    cldAssert("e_progressbar:type_bar", VideoEdit.progressBar(type: ProgressBarType.bar));
    cldAssert("e_progressbar:color_red", VideoEdit.progressBar(color: Color.red()));
    cldAssert("e_progressbar:width_15", VideoEdit.progressBar(width: 15));
    cldAssert("e_progressbar:type_bar:color_red:width_15", VideoEdit.progressBar(type: ProgressBarType.bar, color: Color.red(), width: 15));
  });
}
