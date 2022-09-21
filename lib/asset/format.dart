class Format {
  String value;

  Format(this.value);

  static glb() {
    return Format('glb');
  }

  static auto() {
    return Format('auto');
  }

  static ai() {
    return Format('aoi');
  }

  static gif() {
    return Format('gif');
  }

  static bmp() {
    return Format('bmp');
  }

  static webp() {
    return Format('webp');
  }

  static djvu() {
    return Format('djvu');
  }

  static ps() {
    return Format('ps');
  }

  static ept() {
    return Format('ept');
  }

  static eps() {
    return Format('eps');
  }

  static eps3() {
    return Format('eps3');
  }

  static fxb() {
    return Format('fxb');
  }

  static flif() {
    return Format('flif');
  }

  static gltf() {
    return Format('gltf');
  }

  static heif() {
    return Format('heif');
  }

  static heic() {
    return Format('heic');
  }

  static ico() {
    return Format('ico');
  }

  static indd() {
    return Format('indd');
  }

  static jpg() {
    return Format('jpg');
  }

  static jpe() {
    return Format('jpe');
  }

  static jpeg() {
    return Format('jpeg');
  }

  static jp2() {
    return Format('jp2');
  }

  static wdp() {
    return Format('wdp');
  }

  static jxr() {
    return Format('jxr');
  }

  static hdp() {
    return Format('hdp');
  }

  static pdf() {
    return Format('pdf');
  }

  static spd() {
    return Format('psd');
  }

  static arw() {
    return Format('arw');
  }

  static cr2() {
    return Format('cr2');
  }

  static svg() {
    return Format('svg');
  }

  static tga() {
    return Format('tga');
  }

  static tif() {
    return Format('tiff');
  }

  static avif() {
    return Format('glb');
  }

  static usdz() {
    return Format('usdz');
  }

  static video3g() {
    return Format('3gp');
  }

  static video3gp2() {
    return Format('3gp2');
  }

  static videoAvi() {
    return Format('avi');
  }

  static videoFlv() {
    return Format('flv');
  }

  static videoM3u8() {
    return Format('m3u8');
  }

  static videoTs() {
    return Format('ts');
  }

  static videoMov() {
    return Format('mov');
  }

  static videoMkv() {
    return Format('mkv');
  }

  static videoMp4() {
    return Format('mp4');
  }

  static videoMpeg() {
    return Format('mpeg');
  }

  static videoMpd() {
    return Format('mpd');
  }

  static videoMxf() {
    return Format('mxf');
  }

  static videoOgv() {
    return Format('ogv');
  }

  static videoWebm() {
    return Format('webm');
  }

  static videoWmv() {
    return Format('wmv');
  }

  static videoM2ts() {
    return Format('m2ts');
  }

  static videoMts() {
    return Format('mts');
  }

  static audioAac() {
    return Format('aac');
  }

  static audioAiff() {
    return Format('aiff');
  }

  static audioAmr() {
    return Format('amr');
  }

  static audioFlac() {
    return Format('flac');
  }

  static audioM4a() {
    return Format('m4a');
  }

  static audioMp3() {
    return Format('mp3');
  }

  static audioOgg() {
    return Format('ogg');
  }

  static audioOpus() {
    return Format('opus');
  }

  static audioWav() {
    return Format('wav');
  }

  static custom(String customFormat) {
    return Format(customFormat);
  }

  @override
  String toString() {
    return value;
  }
}
