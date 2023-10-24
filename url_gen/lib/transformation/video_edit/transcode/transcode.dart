import 'transcode_actions.dart';

import '../../common.dart';

class Transcode extends Action {
  static streamingProfile(dynamic profile) {
    return StreamingProfileAction(profile);
  }

  static videoCodec(VideoCodec codec) {
    return VideoCodec(codec);
  }
}
