class Timeline {
  dynamic _startOffset;
  dynamic _duration;
  dynamic _endOffset;

  Timeline startOffset(dynamic startOffset) {
    _startOffset = startOffset;
    return this;
  }

  Timeline endOffset(dynamic endOffset) {
    _endOffset = endOffset;
    return this;
  }

  Timeline duration(dynamic duration) {
    _duration = duration;
    return this;
  }

  dynamic getStartOffset() {
    return _startOffset;
  }

  dynamic getEndOffset() {
    return _endOffset;
  }

  dynamic getDuration() {
    return _duration;
  }
}
