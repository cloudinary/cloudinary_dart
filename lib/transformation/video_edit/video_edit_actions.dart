import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/transformation/video_edit/video_edit.dart';

import '../TransformationUtils.dart';
import '../common.dart';

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
    List<Param?> paramsList = [((_endOffset != null) ? Param('eo', _endOffset) : null),
      ((_startOffset != null) ? Param('so', _startOffset) : null),
      ((_duration != null) ? Param('du', _duration) : null)];
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
    return 'e_volume'.joinWithValues(['$_value${((_suffix != null) ? _suffix : "")}']);
  }

  static Volume mute() => Volume('mute');
  static Volume byPercent(int percentage) => Volume(percentage);
  static Volume byDecibels(int decibels) => Volume(decibels, suffix: 'db');
}