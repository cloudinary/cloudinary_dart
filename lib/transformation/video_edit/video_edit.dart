import 'package:cloudinary_dart/transformation/delivery/delivery_actions.dart';
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

  static Preview preview() {
    return Preview();
  }

  static Waveform waveform(Format format) {
    return Waveform(format);
  }
}
