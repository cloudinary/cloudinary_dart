import '../request/model/params/access_control_rule.dart';
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
  // List<ResultColor>? colors;
  // Map<String, List<ResultColor>>? predominant;
  // List<ResultEager>? eager;
  String? status;
  // Map<String, Coordinates>? coordinates;
  // List<ResultModeration>? moderation;
   List<ResponsiveBreakpoint>? responsiveBreakpoints;
   List<AccessControlRule>? accessControl;
  // ResultQualityAnalysis? qualityAnalysis;
  // ResultCinemagraphAnalysis? cinemagraphAnalysis;
  String? deleteToken;
  // ResultContext? context;
  bool? done;
  // ResultAccessibilityAnalysis? accessibilityAnalysis;
}