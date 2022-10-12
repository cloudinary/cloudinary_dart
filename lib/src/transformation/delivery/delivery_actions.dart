import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/transformation/delivery/delivery.dart';

import '../../../asset/format.dart';
import '../common.dart';
import '../transformation.dart';

class QualityAction extends Delivery {
  dynamic level;
  dynamic quantization;
  ChromaSubSampling? chromaSubSampling;
  bool anyFormat = false;

  QualityAction(this.level,
      {this.chromaSubSampling, this.quantization, this.anyFormat = false});

  @override
  String toString() {
    var anyFormatStr = anyFormat ? "fl_any_format$paramSeparator" : "";
    var quantizationStr = (quantization != null)
        ? "${defaultValuesSeparator}qmax_$quantization"
        : "";
    var chromaSubSamplingStr = (chromaSubSampling != null)
        ? "$defaultValuesSeparator${chromaSubSampling.toString()}"
        : "";
    return "${anyFormatStr}q_$level$chromaSubSamplingStr$quantizationStr";
  }
}

/// Quality Builder
class QualityBuilder implements TransformationComponentBuilder<QualityBuilder> {
  dynamic level;
  bool anyFormat = false;
  ChromaSubSampling? chromaSubSampling;
  dynamic quantization;

  /// Controls the JPEG, WebP, GIF, JPEG XR and JPEG 2000 compression quality.
  ///
  /// Reducing the quality is a trade-off between visual quality and file size.
  ///
  /// Receives [dynamic] level The quality level. 1 is the lowest quality and 100 is the highest.
  QualityBuilder({this.level, this.anyFormat = false});

  /// Controls the final quality by setting a maximum quantization percentage.
  ///
  /// see https://cloudinary.com/documentation/video_manipulation_and_delivery#control_the_quality_of_webm_transcoding
  ///
  /// Receives [dynamic] quantization level.
  ///
  /// Returns [QualityBuilder] object.
  QualityBuilder setQuantization(dynamic quantization) {
    this.quantization = quantization;
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
  QualityBuilder setChromaSubSampling(ChromaSubSampling chromaSubSampling) {
    this.chromaSubSampling = chromaSubSampling;
    return this;
  }

  /// Adds an optional qualifier to accept any format
  ///
  /// Receives [bool] for anyFormat default value: true
  QualityBuilder setAnyFormat([bool anyFormat = true]) {
    this.anyFormat = anyFormat;
    return this;
  }

  @override
  QualityAction build() {
    return QualityAction(level,
        chromaSubSampling: chromaSubSampling,
        quantization: quantization,
        anyFormat: anyFormat);
  }

  /// Builder copy function
  @override
  void copyWith(QualityBuilder other) {
    level = other.level ?? level;
    chromaSubSampling = other.chromaSubSampling;
    quantization = other.quantization;
    anyFormat = other.anyFormat;
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

class DeliveryFormat extends Delivery {
  final Format? _format;
  bool? _lossy;
  Progressive? _progressive;
  bool? _preserveTransparency;
  bool? _ignoreMaskChannels;

  DeliveryFormat(this._format,
      {bool? lossy,
      Progressive? progressive,
      bool? preserveTransparency,
      bool? ignoreMaskChannels}) {
    _lossy = lossy;
    _progressive = progressive;
    _preserveTransparency = preserveTransparency;
    _ignoreMaskChannels = ignoreMaskChannels;
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
    return "f_$_format".joinWithValues([
      lossyStr,
      preserveTransparencyStr,
      progressiveStr,
      ignoreMaskChannelsStr
    ], separator: paramSeparator);
  }
}

class FormatBuilder implements TransformationComponentBuilder<FormatBuilder> {
  Format? format;
  bool? lossy;
  Progressive? progressive;
  bool? preserveTransparency;
  bool? ignoreMaskChannels;

  FormatBuilder(
      {this.format,
      this.lossy,
      this.progressive,
      this.preserveTransparency,
      this.ignoreMaskChannels});

  FormatBuilder setLossy({bool? lossy = true}) {
    this.lossy = lossy;
    return this;
  }


  /// Applicable only for JPG file format
  ///
  /// Receives [Progressive], The mode to determine a specific progressive outcome.
  ///
  /// Returns [FormatBuilder]
  FormatBuilder setProgressive(Progressive progressive) {
    this.progressive = progressive;
    return this;
  }

  /// Ensures that images with a transparency channel will be delivered in PNG format.
  ///
  /// Returns [FormatBuilder]
  FormatBuilder setPreserveTransparency() {
    preserveTransparency = true;
    return this;
  }

  /// Ensures that an alpha channel is not applied to a TIFF image if it is a mask channel.
  ///
  /// Returns [FormatBuilder]
  FormatBuilder setIgnoreMaskChannels() {
    ignoreMaskChannels = true;
    return this;
  }

  @override
  DeliveryFormat build() {
    return DeliveryFormat(format,
        lossy: lossy,
        progressive: progressive,
        preserveTransparency: preserveTransparency,
        ignoreMaskChannels: ignoreMaskChannels);
  }

  /// Builder copy function
  @override
  void copyWith(FormatBuilder other) {
    format = other.format ?? format;
    lossy = other.lossy;
    progressive = other.progressive;
    preserveTransparency = other.preserveTransparency;
    ignoreMaskChannels = other.ignoreMaskChannels;
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
