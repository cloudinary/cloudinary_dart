class StreamingProfile {
  String value;

  StreamingProfile(this.value);

  static sp4K() => StreamingProfile("4k");
  static fullHd() => StreamingProfile("full_hd");
  static hd() => StreamingProfile("hd");
  static sd() => StreamingProfile("sd");
  static fullHdWifi() => StreamingProfile("full_hd_wifi");
  static fullHdLean() => StreamingProfile("full_hd_lean");
  static hdLean() => StreamingProfile("hdLean");

  @override
  String toString() {
    return value;
  }
}

class StreamingProfileAction {
  dynamic profile;

  StreamingProfileAction(this.profile);

  @override
  String toString() {
    return 'sp_$profile';
  }
}
