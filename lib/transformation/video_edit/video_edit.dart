import 'package:cloudinary_dart/transformation/video_edit/video_edit_actions.dart';

import '../common.dart';

class VideoEdit extends Action {
  static Trim trim() {
    return Trim();
  }

  static Volume volume(dynamic volume) {
    if (volume is Volume) {
      return volume;
    }
    return Volume(volume);
  }
}
