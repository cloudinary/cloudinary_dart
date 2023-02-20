import '../request/model/params/access_control_rule.dart';
import '../request/model/params/coordinates.dart';
import '../request/model/params/responsive_breakpoint.dart';

class UploadResult {
  String? publicId;
  String? version;
  String? signature;
  int? width;
  int? height;
  String? format;
  String? resourceType;
  String? createdAt;
  List<String>? tags;
  int? pages;
  int? bytes;
  String? type;
  String? etag;
  bool? placeholder;
  String? url;
  String? secureUrl;
  String? accessMode;
  String? originalFilename;
  List<ResultColor>? colors;
  Map<String, List<ResultColor>>? predominant;
  List<ResultEager>? eager;
  String? status;
  Map<String, Coordinates>? coordinates;
  List<ResultModeration>? moderation;
  List<ResponsiveBreakpoint>? responsiveBreakpoints;
  List<AccessControlRule>? accessControl;
  ResultQualityAnalysis? qualityAnalysis;
  ResultCinemagraphAnalysis? cinemagraphAnalysis;
  String? deleteToken;
  ResultContext? context;
  bool? done;
  ResultAccessibilityAnalysis? accessibilityAnalysis;
}

class ResultCinemagraphAnalysis {
  double score;

  ResultCinemagraphAnalysis(this.score);
}

class ResultColor {
  String color;
  double percent;

  ResultColor(this.color, this.percent);
}

class ResultContext {
  Map<String, String>? custom;

  ResultContext(this.custom);
}

class ResultEager {
  String? transformation;
  int? width;
  int? height;
  int? bytes;
  String? format;
  String? url;
  String? secureUrl;

  ResultEager(
      {this.transformation,
      this.width,
      this.height,
      this.bytes,
      this.format,
      this.url,
      this.secureUrl});
}

class ResultModeration {
  String kind;
  String status;

  ResultModeration(this.kind, this.status);
}

class ResultQualityAnalysis {
  double focus;

  ResultQualityAnalysis(this.focus);
}

class ResultAccessibilityAnalysis {
  ResultColorblindAccessibilityScore colorblindAccessibilityAnalysis;
  double colorblindAccessibilityScore;

  ResultAccessibilityAnalysis(
      this.colorblindAccessibilityAnalysis, this.colorblindAccessibilityScore);
}

class ResultColorblindAccessibilityScore {
  double distinctEdges;
  double distinctColors;
  List<String> mostIndistinctPair;

  ResultColorblindAccessibilityScore(
      this.distinctEdges, this.distinctColors, this.mostIndistinctPair);
}
