import 'package:cloudinary_dart/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/transformation/delivery/delivery.dart';

import '../../asset/format.dart';
import '../common.dart';
import '../transformation.dart';

class QualityAction extends Delivery {
  dynamic level;
  dynamic quantization;
  ChromaSubSampling? chromaSubSampling;
  bool anyFormat = false;

  QualityAction(this.level, {this.chromaSubSampling, this.quantization, this.anyFormat = false});

  @override
  String toString() {
    var anyFormatStr = anyFormat ? "fl_any_format$paramSeparator" : "";
    var quantizationStr = (quantization != null) ? "${defaultValuesSeparator}qmax_$quantization" : "";
    var chromaSubSamplingStr = (chromaSubSampling != null) ? "$defaultValuesSeparator${chromaSubSampling.toString()}" : "";
    return "${anyFormatStr}q_$level$chromaSubSamplingStr$quantizationStr";
  }
}

class QualityBuilder implements TransformationComponentBuilder<QualityBuilder> {

  dynamic level;
  bool anyFormat = false;
  ChromaSubSampling? chromaSubSampling;
  dynamic quantization;

  QualityBuilder({this.level, bool anyFormat = false}) {
    anyFormat = anyFormat;
  }

  QualityBuilder setQuantization(dynamic quantization) {
    quantization = quantization;
    return this;
  }

  QualityBuilder setChromaSubSampling(ChromaSubSampling chromaSubSampling) {
    chromaSubSampling = chromaSubSampling;
    return this;
  }

  QualityBuilder setAnyFormat([bool anyFormat = true]) {
    anyFormat = anyFormat;
    return this;
  }

  @override
  QualityAction build() {
      return QualityAction(level, chromaSubSampling: chromaSubSampling, quantization: quantization, anyFormat: anyFormat);
  }

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

  DeliveryFormat(this._format, {bool? lossy, Progressive? progressive, bool? preserveTransparency, bool? ignoreMaskChannels}) {
    _lossy = lossy;
    _progressive = progressive;
    _preserveTransparency = preserveTransparency;
    _ignoreMaskChannels = ignoreMaskChannels;
  }

  @override
  String toString() {
    var lossyStr = (_lossy == true) ? "fl_lossy" : null;
    var preserveTransparencyStr = (_preserveTransparency == true) ? "fl_preserve_transparency" : null;
    var progressiveStr = (_progressive != null) ? _progressive.toString() : null;
    var ignoreMaskChannelsStr = (_ignoreMaskChannels == true) ? "fl_ignore_mask_channels" : null;
    return "f_$_format".joinWithValues([lossyStr, preserveTransparencyStr, progressiveStr, ignoreMaskChannelsStr], separator: paramSeparator);
  }
}

class FormatBuilder implements TransformationComponentBuilder<FormatBuilder> {

  Format? format;
  bool? lossy;
  Progressive? progressive;
  bool? preserveTransparency;
  bool? ignoreMaskChannels;

  FormatBuilder({Format? format, bool? lossy, Progressive? progressive, bool? preserveTransparency, bool? ignoreMaskChannels}) {
    format = format;
    lossy = lossy;
    progressive = progressive;
    preserveTransparency = preserveTransparency;
    ignoreMaskChannels = ignoreMaskChannels;
  }

  FormatBuilder setLossy({bool? lossy = true}) {
    lossy = lossy;
    return this;
  }

  FormatBuilder setProgressive(Progressive progressive) {
    progressive = progressive;
    return this;
  }

  FormatBuilder setPreserveTransparency() {
    preserveTransparency = true;
    return this;
  }

  FormatBuilder setIgnoreMaskChannels() {
    ignoreMaskChannels = true;
    return this;
  }

  @override
  DeliveryFormat build() {
    return DeliveryFormat(format, lossy: lossy, progressive: progressive, preserveTransparency: preserveTransparency, ignoreMaskChannels: ignoreMaskChannels);
  }

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