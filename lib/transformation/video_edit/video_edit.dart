import 'package:cloudinary_dart/transformation/TransformationUtils.dart';

import '../common.dart';

class VideoEdit extends Action {
  static Trim trim() {
    return Trim();
  }
}

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