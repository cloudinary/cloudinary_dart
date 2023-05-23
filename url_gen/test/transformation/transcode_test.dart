import 'package:cloudinary_url_gen/transformation/video_edit/transcode/transcode.dart';
import 'package:cloudinary_url_gen/transformation/video_edit/transcode/transcode_actions.dart';
import 'package:test/scaffolding.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful streaming profile', () {
    cldAssert('sp_full_hd', Transcode.streamingProfile(StreamingProfile.fullHd()));
    cldAssert('sp_full_hd', Transcode.streamingProfile('full_hd'));
  });
}