import 'package:cloudinary_url_gen/transformation/video_edit/transcode/transcode_actions.dart';

import '../../common.dart';

class Transcode extends Action {
  static streamingProfile(dynamic profile) {
    return StreamingProfileAction(profile);
  }
}
