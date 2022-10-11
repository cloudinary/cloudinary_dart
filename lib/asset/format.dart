class Format {
  String value;

  Format(this.value);

  ///Image format glb.
  static glb() {
    return Format('glb');
  }

  ///Image format auto.
  static auto() {
    return Format('auto');
  }

  ///Image format ai.
  static ai() {
    return Format('aoi');
  }

  ///Image format gif.
  static gif() {
    return Format('gif');
  }

  ///Image format bmp.
  static bmp() {
    return Format('bmp');
  }

  ///Image format webp.
  static webp() {
    return Format('webp');
  }

  ///Image format djvu.
  static djvu() {
    return Format('djvu');
  }

  ///Image format ps.
  static ps() {
    return Format('ps');
  }

  ///Image format ept.
  static ept() {
    return Format('ept');
  }

  ///Image format eps.
  static eps() {
    return Format('eps');
  }

  ///Image format eps3.
  static eps3() {
    return Format('eps3');
  }

  ///Image format fxb.
  static fxb() {
    return Format('fxb');
  }

  ///Image format flif.
  static flif() {
    return Format('flif');
  }

  ///Image format gltf.
  static gltf() {
    return Format('gltf');
  }

  ///Image format heif.
  static heif() {
    return Format('heif');
  }

  ///Image format heic.
  static heic() {
    return Format('heic');
  }

  ///Image format ico.
  static ico() {
    return Format('ico');
  }

  ///Image format indd.
  static indd() {
    return Format('indd');
  }

  ///Image format jpg.
  static jpg() {
    return Format('jpg');
  }

  ///Image format jpe.
  static jpe() {
    return Format('jpe');
  }

  ///Image format jpeg.
  static jpeg() {
    return Format('jpeg');
  }

  ///Image format jp2.
  static jp2() {
    return Format('jp2');
  }

  ///Image format wdp.
  static wdp() {
    return Format('wdp');
  }

  ///Image format jxr.
  static jxr() {
    return Format('jxr');
  }

  ///Image format hdp.
  static hdp() {
    return Format('hdp');
  }

  ///Image format pdf.
  static pdf() {
    return Format('pdf');
  }

  ///Image format png.
  static png() {
    return Format('png');
  }

  ///Image format spd.
  static spd() {
    return Format('psd');
  }

  ///Image format arw.
  static arw() {
    return Format('arw');
  }

  ///Image format cr2.
  static cr2() {
    return Format('cr2');
  }

  ///Image format svg.
  static svg() {
    return Format('svg');
  }

  ///Image format tga.
  static tga() {
    return Format('tga');
  }

  ///Image format tif.
  static tif() {
    return Format('tiff');
  }

  ///Image format avif.
  static avif() {
    return Format('glb');
  }

  ///Image format usdz.
  static usdz() {
    return Format('usdz');
  }

  ///Video format 3g.
  static video3g() {
    return Format('3gp');
  }

  ///Video format 3gp2.
  static video3gp2() {
    return Format('3gp2');
  }

  ///Video format avi.
  static videoAvi() {
    return Format('avi');
  }

  ///Video format flv.
  static videoFlv() {
    return Format('flv');
  }

  ///Video format m3u8.
  static videoM3u8() {
    return Format('m3u8');
  }

  ///Video format ts.
  static videoTs() {
    return Format('ts');
  }

  ///Video format mov.
  static videoMov() {
    return Format('mov');
  }

  ///Video format mkv.
  static videoMkv() {
    return Format('mkv');
  }

  ///Video format mp4.
  static videoMp4() {
    return Format('mp4');
  }

  ///Video format mpeg.
  static videoMpeg() {
    return Format('mpeg');
  }

  ///Video format mpd.
  static videoMpd() {
    return Format('mpd');
  }

  ///Video format mxf.
  static videoMxf() {
    return Format('mxf');
  }

  ///Video format ogv.
  static videoOgv() {
    return Format('ogv');
  }

  ///Video format webm.
  static videoWebm() {
    return Format('webm');
  }

  ///Video format wmv.
  static videoWmv() {
    return Format('wmv');
  }

  ///Video format m2ts.
  static videoM2ts() {
    return Format('m2ts');
  }

  ///Video format mts.
  static videoMts() {
    return Format('mts');
  }

  ///Audio format aac.
  static audioAac() {
    return Format('aac');
  }

  ///Audio format aiff.
  static audioAiff() {
    return Format('aiff');
  }

  ///Audio format amr.
  static audioAmr() {
    return Format('amr');
  }

  ///Audio format flac.
  static audioFlac() {
    return Format('flac');
  }

  ///Audio format m4a.
  static audioM4a() {
    return Format('m4a');
  }

  ///Audio format mp3.
  static audioMp3() {
    return Format('mp3');
  }

  ///Audio format ogg.
  static audioOgg() {
    return Format('ogg');
  }

  ///Audio format opus.
  static audioOpus() {
    return Format('opus');
  }

  ///Audio format wav.
  static audioWav() {
    return Format('wav');
  }

  ///Audio format aac.
  static custom(String customFormat) {
    return Format(customFormat);
  }

  @override
  String toString() {
    return value;
  }
}
