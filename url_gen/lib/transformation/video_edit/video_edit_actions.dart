import 'package:cloudinary_url_gen/src/extensions/string_extension.dart';
import 'package:cloudinary_url_gen/transformation/video_edit/video_edit.dart';

import '../color.dart';
import '../common.dart';
import '../delivery/delivery_actions.dart';
import '../effect/effect.dart';
import '../flag.dart';
import '../transformation_utils.dart';

class Trim extends VideoEdit {
  dynamic _startOffset;
  dynamic _endOffset;
  dynamic _duration;

  Trim({dynamic startOffset, dynamic endOffset, dynamic duration}) {
    _startOffset = startOffset;
    _endOffset = endOffset;
    _duration = duration;
    var valuesList = [_startOffset, _endOffset, _duration];
    valuesList.removeWhere((element) => element == null);
    if (valuesList.isEmpty || valuesList.length > 2) {
      ArgumentError('Wrong number of parameters sent to Trim');
    }
  }

  @override
  String toString() {
    List<Param?> paramsList = [
      ((_endOffset != null) ? Param('eo', _endOffset) : null),
      ((_startOffset != null) ? Param('so', _startOffset) : null),
      ((_duration != null) ? Param('du', _duration) : null)
    ];
    return toComponentString(paramsList);
  }

  Trim startOffset(dynamic offset) {
    _startOffset = offset;
    return this;
  }

  Trim endOffset(dynamic offset) {
    _endOffset = offset;
    return this;
  }

  Trim duration(dynamic duration) {
    _duration = duration;
    return this;
  }
}

class Volume extends VideoEdit {
  dynamic _value;
  String? _suffix;

  Volume(dynamic value, {String? suffix}) {
    _value = value;
    _suffix = suffix;
  }

  @override
  String toString() {
    return 'e_volume'
        .joinWithValues(['$_value${((_suffix != null) ? _suffix : "")}']);
  }

  static Volume mute() => Volume('mute');
  static Volume byPercent(int percentage) => Volume(percentage);
  static Volume byDecibels(int decibels) => Volume(decibels, suffix: 'db');
}

class Preview extends VideoEdit {
  double? _duration;
  int? _maximumSegments;
  dynamic _minimumSegmentDuration;

  Preview(
      {double? duration,
      int? maximumSegments,
      dynamic minimumSegmentDuration}) {
    _duration = duration;
    _maximumSegments = maximumSegments;
    _minimumSegmentDuration = minimumSegmentDuration;
  }

  @override
  String toString() {
    return 'e_preview'.joinWithValues([
      ((_duration != null) ? 'duration_$_duration' : null),
      ((_maximumSegments != null) ? 'max_seg_$_maximumSegments' : null),
      ((_minimumSegmentDuration != null)
          ? 'min_seg_dur_$_minimumSegmentDuration'
          : null)
    ]);
  }

  Preview duration(double duration) {
    _duration = duration;
    return this;
  }

  Preview maximumSegments(int maximumSegments) {
    _maximumSegments = maximumSegments;
    return this;
  }

  Preview minimumSegmentDuration(dynamic minimumSegmentDuration) {
    _minimumSegmentDuration = minimumSegmentDuration;
    return this;
  }
}

class Waveform extends Effect {
  Format _format;
  dynamic _color;
  dynamic _background;

  Waveform(this._format, {dynamic color, Color? background}) {
    _color = color;
    _background = background;
  }

  @override
  String toString() {
    List<String?> paramsList = [
      '$_format',
      ((_background != null) ? 'b_$_background' : null),
      ((_color != null) ? 'co_$_color' : null)
    ];
    paramsList.add(Flag.waveform().toString());
    return asComponentString(paramsList);
  }

  Waveform color(Color color) {
    _color = color;
    return this;
  }

  Waveform background(Color background) {
    _background = background;
    return this;
  }
}
