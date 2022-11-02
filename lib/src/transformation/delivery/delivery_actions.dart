import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import '../common.dart';
import '../transformation.dart';
import 'delivery.dart';

/// Quality Builder
class Quality implements TransformationComponentBuilder<Quality>, DeliveryAction {
  static const String auto = 'auto';
  static const String autoEco = 'auto:eco';
  static const String autoGood = 'auto:good';
  static const String autoBest = 'auto:best';
  static const String autoLow = 'auto:low';
  static const String jpegmini = 'jpegmini';
  static const String jpegminiHigh = 'jpegmini:1';
  static const String jpegminiMedium = 'jpegmini:2';
  static const String jpegminiBest = 'jpegmini:0';

  dynamic level;
  bool _anyFormat = false;
  ChromaSubSampling? _chromaSubSampling;
  dynamic _quantization;

  /// Controls the JPEG, WebP, GIF, JPEG XR and JPEG 2000 compression quality.
  ///
  /// Reducing the quality is a trade-off between visual quality and file size.
  ///
  /// Receives [dynamic] level The quality level. 1 is the lowest quality and 100 is the highest.
  Quality(this.level, {bool anyFormat = false}) {
    _anyFormat = anyFormat;
  }

  /// Controls the final quality by setting a maximum quantization percentage.
  ///
  /// see https://cloudinary.com/documentation/video_manipulation_and_delivery#control_the_quality_of_webm_transcoding
  ///
  /// Receives [dynamic] quantization level.
  ///
  /// Returns [QualityBuilder] object.
  Quality quantization(dynamic quantization) {
    _quantization = quantization;
    return this;
  }

  /// Adds an optional qualifier to control chroma subsampling.
  ///
  /// Chroma sub-sampling is a method of encoding images by implementing less resolution for chroma information
  /// (colors) than for luma information (luminance), taking advantage of the human visual system's lower acuity for
  /// color differences than for luminance.
  ///
  /// Receives [String] chromaSubSampling Chroma sub-sampling value.
  ///
  /// Returns [QualityBuilder] object.
  Quality chromaSubSampling(ChromaSubSampling chromaSubSampling) {
    _chromaSubSampling = chromaSubSampling;
    return this;
  }

  /// Adds an optional qualifier to accept any format
  ///
  /// Receives [bool] for anyFormat default value: true
  Quality anyFormat([bool anyFormat = true]) {
    _anyFormat = anyFormat;
    return this;
  }

  /// Builder copy function
  @override
  void copyWith(Quality other) {
    level = other.level ?? level;
    _chromaSubSampling = other._chromaSubSampling;
    _quantization = other._quantization;
    _anyFormat = other._anyFormat;
  }

  @override
  String toString() {
    var anyFormatStr = _anyFormat ? "fl_any_format$paramSeparator" : "";
    var quantizationStr = (_quantization != null)
        ? "${defaultValuesSeparator}qmax_$_quantization"
        : "";
    var chromaSubSamplingStr = (_chromaSubSampling != null)
        ? "$defaultValuesSeparator${_chromaSubSampling.toString()}"
        : "";
    return "${anyFormatStr}q_$level$chromaSubSamplingStr$quantizationStr";
  }
}

class ChromaSubSampling {
  String value;

  ChromaSubSampling(this.value);

  static ChromaSubSampling chroma444() => ChromaSubSampling("444");

  static ChromaSubSampling chroma420() => ChromaSubSampling("420");

  @override
  String toString() {
    return value;
  }
}

class Format implements TransformationComponentBuilder<Format>, DeliveryAction {
  static const String glb = 'glb';
  static const String auto = 'auto';
  static const String ai = 'ai';
  static const String gif = 'gif';
  static const String bmp = 'bmp';
  static const String webp = 'webp';
  static const String djvu = 'djvu';
  static const String ps = 'ps';
  static const String ept = 'ept';
  static const String eps = 'eps';
  static const String eps3 = 'eps3';
  static const String fxb = 'fxb';
  static const String flif = 'flif';
  static const String gltf = 'gltf';
  static const String heif = 'heif';
  static const String heic = 'heic';
  static const String ico = 'ico';
  static const String indd = 'indd';
  static const String jpg = 'jpg';
  static const String jpe = 'jpe';
  static const String jpeg = 'jpeg';
  static const String jp2 = 'jp2';
  static const String wdp = 'wdp';
  static const String jxr = 'jxr';
  static const String hdp = 'hdp';
  static const String pdf = 'pdf';
  static const String png = 'png';
  static const String spd = 'spd';
  static const String arw = 'arw';
  static const String cr2 = 'cr2';
  static const String svg = 'svg';
  static const String tga = 'tga';
  static const String tiff = 'tiff';
  static const String avif = 'avif';
  static const String usdz = 'usdz';
  static const String video3g = '3g';
  static const String video3gp2 = '3gp2';
  static const String videoAvi = 'avi';
  static const String videoFlv = 'flv';
  static const String videoM3u8 = 'm3u8';
  static const String videoTs = 'ts';
  static const String videoMov = 'mov';
  static const String videoMkv = 'mkv';
  static const String videoMp4 = 'mp4';
  static const String videoMpeg = 'mpeg';
  static const String videoMpd = 'mpd';
  static const String videoMxf = 'mxf';
  static const String videoOgv = 'ogv';
  static const String videoWebm = 'webm';
  static const String videoWmv = 'wmv';
  static const String videoM2ts = 'm2ts';
  static const String videoMts = 'mts';
  static const String audioAac = 'aac';
  static const String audioAiff = 'aiff';
  static const String audioAmr = 'amr';
  static const String audioFlac = 'flac';
  static const String audioM4a = 'm4a';
  static const String audioMp3 = 'mp3';
  static const String audioOgg = 'ogg';
  static const String audioOpus = 'opus';
  static const String audioWav = 'wav';
  static String custom(String format) {
    return format;
  }

  String? format;
  bool? _lossy;
  Progressive? _progressive;
  bool? _preserveTransparency;
  bool? _ignoreMaskChannels;

  Format(this.format,
      {bool? lossy,
      Progressive? progressive,
      bool? preserveTransparency,
      bool? ignoreMaskChannels}) {
    _lossy = lossy;
    _progressive = progressive;
    _preserveTransparency = preserveTransparency;
    _ignoreMaskChannels = ignoreMaskChannels;
  }

  Format.withString(String format,
      {bool? lossy,
      Progressive? progressive,
      bool? preserveTransparency,
      bool? ignoreMaskChannels}) {
    this.format = Format.custom(format);
    _lossy = lossy;
    _progressive = progressive;
    _preserveTransparency = preserveTransparency;
    _ignoreMaskChannels = ignoreMaskChannels;
  }

  Format lossy([bool? lossy = true]) {
    _lossy = lossy;
    return this;
  }

  /// Applicable only for JPG file format
  ///
  /// Receives [Progressive], The mode to determine a specific progressive outcome.
  ///
  /// Returns [Format]
  Format progressive(Progressive progressive) {
    _progressive = progressive;
    return this;
  }

  /// Ensures that images with a transparency channel will be delivered in PNG format.
  ///
  /// Returns [Format]
  Format preserveTransparency() {
    _preserveTransparency = true;
    return this;
  }

  /// Ensures that an alpha channel is not applied to a TIFF image if it is a mask channel.
  ///
  /// Returns [Format]
  Format ignoreMaskChannels() {
    _ignoreMaskChannels = true;
    return this;
  }

  /// Builder copy function
  @override
  void copyWith(Format other) {
    format = other.format ?? format;
    _lossy = other._lossy;
    _progressive = other._progressive;
    _preserveTransparency = other._preserveTransparency;
    _ignoreMaskChannels = other._ignoreMaskChannels;
  }

  @override
  String toString() {
    var lossyStr = (_lossy == true) ? "fl_lossy" : null;
    var preserveTransparencyStr =
        (_preserveTransparency == true) ? "fl_preserve_transparency" : null;
    var progressiveStr =
        (_progressive != null) ? _progressive.toString() : null;
    var ignoreMaskChannelsStr =
        (_ignoreMaskChannels == true) ? "fl_ignore_mask_channels" : null;
    return "f_$format".joinWithValues([
      lossyStr,
      preserveTransparencyStr,
      progressiveStr,
      ignoreMaskChannelsStr
    ], separator: paramSeparator);
  }
}

class Progressive {
  ProgressiveMode? _mode;

  Progressive([ProgressiveMode? mode]) {
    _mode = mode;
  }

  static Progressive none() => Progressive(ProgressiveMode("none"));

  static Progressive semi() => Progressive(ProgressiveMode("semi"));

  static Progressive steep() => Progressive(ProgressiveMode("steep"));

  static Progressive progressive() => Progressive();

  @override
  String toString() {
    return "fl_progressive".joinWithValues([_mode]);
  }
}

class ProgressiveMode {
  final String _value;

  ProgressiveMode(this._value);

  static ProgressiveMode none() => ProgressiveMode("none");

  static ProgressiveMode semi() => ProgressiveMode("semi");

  static ProgressiveMode steep() => ProgressiveMode("steep");

  @override
  String toString() {
    return _value;
  }
}


class DeliveryAction extends Action {

}