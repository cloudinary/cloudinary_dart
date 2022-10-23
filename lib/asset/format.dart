class FormatValue {
  String value;

  FormatValue(this.value);

  ///Image format glb.
  static glb() {
    return FormatValue('glb');
  }

  ///Image format auto.
  static auto() {
    return FormatValue('auto');
  }

  ///Image format ai.
  static ai() {
    return FormatValue('aoi');
  }

  ///Image format gif.
  static gif() {
    return FormatValue('gif');
  }

  ///Image format bmp.
  static bmp() {
    return FormatValue('bmp');
  }

  ///Image format webp.
  static webp() {
    return FormatValue('webp');
  }

  ///Image format djvu.
  static djvu() {
    return FormatValue('djvu');
  }

  ///Image format ps.
  static ps() {
    return FormatValue('ps');
  }

  ///Image format ept.
  static ept() {
    return FormatValue('ept');
  }

  ///Image format eps.
  static eps() {
    return FormatValue('eps');
  }

  ///Image format eps3.
  static eps3() {
    return FormatValue('eps3');
  }

  ///Image format fxb.
  static fxb() {
    return FormatValue('fxb');
  }

  ///Image format flif.
  static flif() {
    return FormatValue('flif');
  }

  ///Image format gltf.
  static gltf() {
    return FormatValue('gltf');
  }

  ///Image format heif.
  static heif() {
    return FormatValue('heif');
  }

  ///Image format heic.
  static heic() {
    return FormatValue('heic');
  }

  ///Image format ico.
  static ico() {
    return FormatValue('ico');
  }

  ///Image format indd.
  static indd() {
    return FormatValue('indd');
  }

  ///Image format jpg.
  static jpg() {
    return FormatValue('jpg');
  }

  ///Image format jpe.
  static jpe() {
    return FormatValue('jpe');
  }

  ///Image format jpeg.
  static jpeg() {
    return FormatValue('jpeg');
  }

  ///Image format jp2.
  static jp2() {
    return FormatValue('jp2');
  }

  ///Image format wdp.
  static wdp() {
    return FormatValue('wdp');
  }

  ///Image format jxr.
  static jxr() {
    return FormatValue('jxr');
  }

  ///Image format hdp.
  static hdp() {
    return FormatValue('hdp');
  }

  ///Image format pdf.
  static pdf() {
    return FormatValue('pdf');
  }

  ///Image format png.
  static png() {
    return FormatValue('png');
  }

  ///Image format spd.
  static spd() {
    return FormatValue('psd');
  }

  ///Image format arw.
  static arw() {
    return FormatValue('arw');
  }

  ///Image format cr2.
  static cr2() {
    return FormatValue('cr2');
  }

  ///Image format svg.
  static svg() {
    return FormatValue('svg');
  }

  ///Image format tga.
  static tga() {
    return FormatValue('tga');
  }

  ///Image format tif.
  static tif() {
    return FormatValue('tiff');
  }

  ///Image format avif.
  static avif() {
    return FormatValue('glb');
  }

  ///Image format usdz.
  static usdz() {
    return FormatValue('usdz');
  }

  ///Video format 3g.
  static video3g() {
    return FormatValue('3gp');
  }

  ///Video format 3gp2.
  static video3gp2() {
    return FormatValue('3gp2');
  }

  ///Video format avi.
  static videoAvi() {
    return FormatValue('avi');
  }

  ///Video format flv.
  static videoFlv() {
    return FormatValue('flv');
  }

  ///Video format m3u8.
  static videoM3u8() {
    return FormatValue('m3u8');
  }

  ///Video format ts.
  static videoTs() {
    return FormatValue('ts');
  }

  ///Video format mov.
  static videoMov() {
    return FormatValue('mov');
  }

  ///Video format mkv.
  static videoMkv() {
    return FormatValue('mkv');
  }

  ///Video format mp4.
  static videoMp4() {
    return FormatValue('mp4');
  }

  ///Video format mpeg.
  static videoMpeg() {
    return FormatValue('mpeg');
  }

  ///Video format mpd.
  static videoMpd() {
    return FormatValue('mpd');
  }

  ///Video format mxf.
  static videoMxf() {
    return FormatValue('mxf');
  }

  ///Video format ogv.
  static videoOgv() {
    return FormatValue('ogv');
  }

  ///Video format webm.
  static videoWebm() {
    return FormatValue('webm');
  }

  ///Video format wmv.
  static videoWmv() {
    return FormatValue('wmv');
  }

  ///Video format m2ts.
  static videoM2ts() {
    return FormatValue('m2ts');
  }

  ///Video format mts.
  static videoMts() {
    return FormatValue('mts');
  }

  ///Audio format aac.
  static audioAac() {
    return FormatValue('aac');
  }

  ///Audio format aiff.
  static audioAiff() {
    return FormatValue('aiff');
  }

  ///Audio format amr.
  static audioAmr() {
    return FormatValue('amr');
  }

  ///Audio format flac.
  static audioFlac() {
    return FormatValue('flac');
  }

  ///Audio format m4a.
  static audioM4a() {
    return FormatValue('m4a');
  }

  ///Audio format mp3.
  static audioMp3() {
    return FormatValue('mp3');
  }

  ///Audio format ogg.
  static audioOgg() {
    return FormatValue('ogg');
  }

  ///Audio format opus.
  static audioOpus() {
    return FormatValue('opus');
  }

  ///Audio format wav.
  static audioWav() {
    return FormatValue('wav');
  }

  ///Audio format aac.
  static custom(String customFormat) {
    return FormatValue(customFormat);
  }

  @override
  String toString() {
    return value;
  }
}
