import '../color.dart';
import 'video_edit_actions.dart';
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

  static progressBar({ProgressBarType? type, Color? color, int? width}) {
    return ProgressBar(type: type, color: color, width: width);
  }
}
