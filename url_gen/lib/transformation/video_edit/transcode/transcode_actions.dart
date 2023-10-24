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

class VideoCodec {

  dynamic codec;

  VideoCodec(this.codec);

  static vp8() => VideoCodec('vp8');
  static vp9() => VideoCodec('vp9');
  static prores() => VideoCodec('prores');

  VideoCodec h264({VideoCodecProfile? profile, dynamic level}) {
    return H264Codec(profile: profile, level: level);
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
    return (codec as String).joinWithValues([_profile.toString(), _level.toString()]);
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
