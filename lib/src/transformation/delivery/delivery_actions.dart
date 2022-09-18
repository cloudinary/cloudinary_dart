import 'package:cloudinary_dart/src/transformation/delivery/delivery.dart';

import '../common.dart';
import '../transformation.dart';

class QualityAction extends Delivery{
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
  bool _anyFormat = false;
  ChromaSubSampling? _chromaSubSampling;
  dynamic _quantization;

  QualityBuilder({this.level, bool anyFormat = false}) {
    _anyFormat = anyFormat;
  }

  QualityBuilder quantization(dynamic quantization) {
    _quantization = quantization;
    return this;
  }

  QualityBuilder chromaSubSampling(ChromaSubSampling chromaSubSampling) {
    _chromaSubSampling = chromaSubSampling;
    return this;
  }

  QualityBuilder anyFormat([bool anyFormat = true]) {
    _anyFormat = anyFormat;
    return this;
  }

  @override
  QualityAction build() {
      return QualityAction(level, chromaSubSampling: _chromaSubSampling, quantization: _quantization, anyFormat: _anyFormat);
  }

  @override
  void copyWith(QualityBuilder other) {
      level = other.level ?? level;
      _chromaSubSampling = other._chromaSubSampling;
      _quantization = other._quantization;
      _anyFormat = other._anyFormat;
  }
}

class ChromaSubSampling {

  String value;

  ChromaSubSampling(this.value);

  static ChromaSubSampling chroma444() {
    return ChromaSubSampling("444");
  }

  static ChromaSubSampling chroma420() {
    return ChromaSubSampling("420");
  }

  @override
  String toString() {
    return value;
  }
}