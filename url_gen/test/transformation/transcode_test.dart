import 'package:cloudinary_url_gen/src/transformation/video_edit/transcode/transcode.dart';
import 'package:cloudinary_url_gen/src/transformation/video_edit/transcode/transcode_actions.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful streaming profile', () {
    cldAssert(
        'sp_full_hd', Transcode.streamingProfile(StreamingProfile.fullHd()));
    cldAssert('sp_full_hd', Transcode.streamingProfile('full_hd'));
  });

  test('Test successful video codec', () {
    cldAssert('vc_vp8', Transcode.videoCodec(VideoCodec.vp8()));
    cldAssert("vc_h264:baseline", Transcode.videoCodec(VideoCodec.h264(profile: VideoCodecProfile.baseline())));
    cldAssert("vc_h264:high:3.1", Transcode.videoCodec(VideoCodec.h264(profile: VideoCodecProfile.high(), level: VideoCodecLevel.vcl31())));
    cldAssert("vc_h265", Transcode.videoCodec(VideoCodec.h265()));
    cldAssert("vc_h265:auto:auto:bframes_no", Transcode.videoCodec(VideoCodec.h265(profile: VideoCodecProfile.auto(), level: VideoCodecLevel.auto(), bFrames: false)));
  });
}
