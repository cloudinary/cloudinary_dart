import 'package:cloudinary_url_gen/src/extensions/string_extension.dart';

import 'transcode.dart';

class StreamingProfile {
  String value;

  StreamingProfile(this.value);

  static auto() => StreamingProfile('auto');
  static sp4K() => StreamingProfile('4k');
  static fullHd() => StreamingProfile('full_hd');
  static hd() => StreamingProfile('hd');
  static sd() => StreamingProfile('sd');
  static fullHdWifi() => StreamingProfile('full_hd_wifi');
  static fullHdLean() => StreamingProfile('full_hd_lean');
  static hdLean() => StreamingProfile('hdLean');

  @override
  String toString() {
    return value;
  }
}

class StreamingProfileAction extends Transcode {
  dynamic profile;

  StreamingProfileAction(this.profile);

  @override
  String toString() {
    return 'sp_$profile';
  }
}

class VideoCodecAction extends Transcode {
  dynamic codec;

  VideoCodecAction(this.codec);

  @override
  String toString() {
    return 'vc_$codec';
  }
}

class VideoCodec {

  dynamic codec;

  VideoCodec(this.codec);

  static vp8() => VideoCodec('vp8');
  static vp9() => VideoCodec('vp9');
  static prores() => VideoCodec('prores');

  static h264({VideoCodecProfile? profile, dynamic level}) {
    return H264Codec(profile: profile, level: level);
  }

  static h265({VideoCodecProfile? profile, dynamic level, bool? bFrames}) {
    return H265Codec(profile: profile, level: level, bFrames: bFrames);
  }

  @override
  String toString() {
    return codec;
  }
}

class H265Codec extends VideoCodec {
  VideoCodecProfile? _profile;
  dynamic _level;
  bool? _bFrames;

  H265Codec({VideoCodecProfile? profile, dynamic level, bool? bFrames}): super('h265') {
    _profile = profile;
    _level = level;
    _bFrames = bFrames;
  }

  H265Codec profile(VideoCodecProfile profile) {
    _profile = profile;
    return this;
  }

  H265Codec level(dynamic level) {
    _level = level;
    return this;
  }

  H265Codec bFrames(bool bFrames) {
    _bFrames = bFrames;
    return this;
  }

  @override
  String toString() {
    return (codec as String).joinWithValues([(_profile != null) ? _profile.toString() : null, (_level != null) ? _level.toString() : null, (_bFrames != null && !_bFrames!) ? 'bframes_no' : null]);
  }
}

class H264Codec extends VideoCodec {

  VideoCodecProfile? _profile;
  dynamic _level;

  H264Codec({VideoCodecProfile? profile, dynamic level}): super('h264') {
    _profile = profile;
    _level = level;
  }

  H264Codec profile(VideoCodecProfile profile) {
    _profile = profile;
    return this;
  }

  H264Codec level(dynamic level) {
    _level = level;
    return this;
  }

  @override
  String toString() {
    return (codec as String).joinWithValues([(_profile != null) ? _profile.toString() : null, (_level != null) ? _level.toString() : null]);
  }
}

class VideoCodecProfile extends Transcode {

  String value;

  VideoCodecProfile(this.value);

  static main() => VideoCodecProfile('main');
  static baseline() => VideoCodecProfile('baseline');
  static high() => VideoCodecProfile('high');
  static auto() => VideoCodecProfile('auto');

  @override
  String toString() {
    return value;
  }
}

class VideoCodecLevel {

  String value;

  VideoCodecLevel(this.value);

  static vcl30() => VideoCodecLevel('3.0');
  static vcl31() => VideoCodecLevel('3.1');
  static vcl40() => VideoCodecLevel('4.0');
  static vcl41() => VideoCodecLevel('4.1');
  static vcl42() => VideoCodecLevel('4.2');
  static vcl50() => VideoCodecLevel('5.0');
  static vcl51() => VideoCodecLevel('5.1');
  static vcl52() => VideoCodecLevel('5.2');
  static auto() => VideoCodecLevel('auto');

  @override
  String toString() {
    return value;
  }
}
