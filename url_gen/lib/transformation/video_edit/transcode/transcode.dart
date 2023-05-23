import 'transcode_actions.dart';

import '../../common.dart';

class Transcode extends Action {
  static streamingProfile(StreamingProfile profile) {
    return StreamingProfileAction(profile);
  }
}
