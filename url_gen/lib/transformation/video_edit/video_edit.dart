import 'package:cloudinary_url_gen/transformation/video_edit/video_edit_actions.dart';
import '../common.dart';
import '../delivery/delivery_actions.dart';

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
