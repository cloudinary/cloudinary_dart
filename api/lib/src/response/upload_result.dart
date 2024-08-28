import 'dart:ffi';

import '../request/model/params/access_control_rule.dart';
import '../request/model/params/coordinates.dart';

class UploadResult {
  String? publicId;
  int? version;
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
  String? folder;
  String? accessMode;
  String? originalFilename;
  List<ResultColor>? colors;
  Map<String, List<ResultColor>>? predominant;
  List<ResultEager>? eager;
  String? status;
  Coordinates? faces;
  Map<String, Coordinates>? coordinates;
  List<ResultModeration>? moderation;
  List<ResultResponsiveBreakpoint>? responsiveBreakpoints;
  List<AccessControlRule>? accessControl;
  ResultQualityAnalysis? qualityAnalysis;
  ResultCinemagraphAnalysis? cinemagraphAnalysis;
  String? deleteToken;
  ResultContext? context;
  bool? done;
  ResultAccessibilityAnalysis? accessibilityAnalysis;
  Map<String, dynamic>? imageMetadata;
  VideoResultObject? video;
  AudioResultObject? audio;
  List<String>? publicIds;

  UploadResult(
      {this.publicId,
      this.version,
      this.signature,
      this.width,
      this.height,
      this.format,
      this.resourceType,
      this.createdAt,
      this.tags,
      this.pages,
      this.bytes,
      this.type,
      this.etag,
      this.placeholder,
      this.url,
      this.secureUrl,
      this.folder,
      this.accessMode,
      this.originalFilename,
      this.colors,
      this.predominant,
      this.eager,
      this.status,
      this.faces,
      this.coordinates,
      this.moderation,
      this.responsiveBreakpoints,
      this.accessControl,
      this.qualityAnalysis,
      this.cinemagraphAnalysis,
      this.deleteToken,
      this.context,
      this.done,
      this.accessibilityAnalysis,
      this.imageMetadata,
      this.video,
      this.audio,
      this.publicIds});

  factory UploadResult.fromJson(Map<String, dynamic> data) {
    final publicId = data['public_id'] as String?;
    final version = data['version'] as int?;
    final signature = data['signature'] as String?;
    final width = data['width'] as int?;
    final height = data['height'] as int?;
    final format = data['format'] as String?;
    final resourceType = data['resource_type'] as String?;
    final createdAt = data['created_at'] as String?;
    final tags =
        (data['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList();
    final pages = data['version'] as int?;
    final bytes = data['version'] as int?;
    final type = data['type'] as String?;
    final etag = data['etag'] as String?;
    final placeholder = data['placeholder'] as bool?;
    final url = data['url'] as String?;
    final secureUrl = data['secure_url'] as String?;
    final folder = data['folder'] as String?;
    final accessMode = data['access_mode'] as String?;
    final originalFilename = data['original_filename'] as String?;
    final colors = (data['colors'] as List<dynamic>?)
        ?.map((value) => ResultColor.fromJson(value))
        .toList();
    final predominant = (data['predominant'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
            key,
            (value as List<dynamic>)
                .map((e) => ResultColor.fromJson(e))
                .toList()));
    final eager = (data['eager'] as List<dynamic>?)
        ?.map((value) => ResultEager.fromJson(value))
        .toList();
    final status = data['status'] as String?;
    final faces =
        (data['faces'] != null) ? Coordinates.fromJson(data['faces']) : null;
    final coordinates = (data['coordinates'] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(key, Coordinates.fromJson(value)));
    final moderation = (data['moderation'] as List<dynamic>?)
        ?.map((value) => ResultModeration.fromJson(value))
        .toList();
    final responsiveBreakpoints =
        (data['responsive_breakpoints'] as List<dynamic>?)
            ?.map((value) => ResultResponsiveBreakpoint.fromJson(value))
            .toList();
    final accessControl = (data['access_control'] as List<dynamic>?)
        ?.map((value) => AccessControlRule.fromJson(value))
        .toList();
    final qualityAnalysis = (data['quality_analysis'] != null)
        ? ResultQualityAnalysis.fromJson(data['quality_analysis'])
        : null;
    final cinemagraphAnalysis = (data['cinemagraph_analysis'] != null)
        ? ResultCinemagraphAnalysis.fromJson(data['cinemagraph_analysis'])
        : null;
    final deleteToken = data['delete_token'] as String?;
    final context = (data['context'] != null)
        ? ResultContext.fromJson(data['context'])
        : null;
    final done = data['done'] as bool?;
    final accessibilityAnalysis = (data['accessibility_analysis'] != null)
        ? ResultAccessibilityAnalysis.fromJson(data['accessibility_analysis'])
        : null;
    final imageMetadata = data['image_metadata'];
    final video = (data['video'] != null) ? VideoResultObject.fromJson(data['video']) : null;
    final audio = (data['audio'] != null) ? AudioResultObject.fromJson(data['audio']) : null;
    final publicIds = (data['public_ids'] as List<dynamic>?)?.map((e) => e.toString()).toList();

    return UploadResult(
        publicId: publicId,
        version: version,
        signature: signature,
        width: width,
        height: height,
        format: format,
        resourceType: resourceType,
        createdAt: createdAt,
        tags: tags,
        pages: pages,
        bytes: bytes,
        type: type,
        etag: etag,
        placeholder: placeholder,
        url: url,
        secureUrl: secureUrl,
        folder: folder,
        accessMode: accessMode,
        originalFilename: originalFilename,
        colors: colors,
        predominant: predominant,
        eager: eager,
        status: status,
        faces: faces,
        coordinates: coordinates,
        moderation: moderation,
        responsiveBreakpoints: responsiveBreakpoints,
        accessControl: accessControl,
        qualityAnalysis: qualityAnalysis,
        cinemagraphAnalysis: cinemagraphAnalysis,
        deleteToken: deleteToken,
        context: context,
        done: done,
        accessibilityAnalysis: accessibilityAnalysis,
        imageMetadata: imageMetadata,
        video: video,
        audio: audio,
        publicIds: publicIds);
  }
}

class ResultCinemagraphAnalysis {
  double score;

  ResultCinemagraphAnalysis(this.score);

  factory ResultCinemagraphAnalysis.fromJson(Map<String, dynamic> data) {
    final score = data['cinemagraph_score'] as double;
    return ResultCinemagraphAnalysis(score);
  }
}

class ResultColor {
  String color;
  double percent;

  ResultColor(this.color, this.percent);

  factory ResultColor.fromJson(List<dynamic> data) {
    final color = data[0] as String;
    final percent = data[1] as double;
    return ResultColor(color, percent);
  }
}

class ResultContext {
  Map<String, dynamic>? custom;

  ResultContext(this.custom);

  factory ResultContext.fromJson(Map<String, dynamic> data) {
    final custom = data['custom'] as Map<String, dynamic>?;
    return ResultContext(custom);
  }
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

  factory ResultEager.fromJson(Map<String, dynamic> data) {
    final transformation = data['transformation'] as String?;
    final width = data['width'] as int?;
    final height = data['height'] as int?;
    final bytes = data['bytes'] as int?;
    final format = data['format'] as String?;
    final url = data['url'] as String?;
    final secureUrl = data['secure_url'] as String?;
    return ResultEager(
        transformation: transformation,
        width: width,
        height: height,
        bytes: bytes,
        format: format,
        url: url,
        secureUrl: secureUrl);
  }
}

class ResultModeration {
  String kind;
  String status;

  ResultModeration(this.kind, this.status);

  factory ResultModeration.fromJson(Map<String, dynamic> data) {
    final kind = data['kind'] as String;
    final status = data['status'] as String;
    return ResultModeration(kind, status);
  }
}

class ResultQualityAnalysis {
  double focus;

  ResultQualityAnalysis(this.focus);

  factory ResultQualityAnalysis.fromJson(Map<String, dynamic> data) {
    final focus = data['focus'] as double;
    return ResultQualityAnalysis(focus);
  }
}

class ResultAccessibilityAnalysis {
  ResultColorblindAccessibilityScore colorblindAccessibilityAnalysis;
  double colorblindAccessibilityScore;

  ResultAccessibilityAnalysis(
      this.colorblindAccessibilityAnalysis, this.colorblindAccessibilityScore);

  factory ResultAccessibilityAnalysis.fromJson(Map<String, dynamic> data) {
    final colorblindAccessibilityAnalysis =
        ResultColorblindAccessibilityScore.fromJson(
            data['colorblind_accessibility_analysis']);
    final colorblindAccessibilityScore =
        data['colorblind_accessibility_score'] as double;
    return ResultAccessibilityAnalysis(
        colorblindAccessibilityAnalysis, colorblindAccessibilityScore);
  }
}

class AudioResultObject {
  String? codec;
  String? bitRate;
  int? frequency;
  int? channels;
  String? channelLayout;

  AudioResultObject({this.codec, this.bitRate, this.frequency, this.channels, this.channelLayout});

  factory AudioResultObject.fromJson(Map<String, dynamic> data) {
    final codec = data['codec'] as String?;
    final bitRate = data['bit_rate'] as String?;
    final frequency = data['frequency'] as int?;
    final channels = data['channels'] as int?;
    final channelLayout = data['channel_layout'] as String?;

    return AudioResultObject(codec: codec, bitRate: bitRate, frequency: frequency, channels: channels, channelLayout: channelLayout);
  }
}

class VideoResultObject {
  String? pixFormat;
  String? codec;
  int? level;
  String? profile;
  String? bitRate;
  String? dar;
  String? timeBase;
  Map<String, dynamic>? metadata;

  VideoResultObject({this.pixFormat, this.codec, this.level, this.profile, this.bitRate, this.dar, this.timeBase, this.metadata});

  factory VideoResultObject.fromJson(Map<String, dynamic> data) {
    final pixFormat = data['pix_format'] as String?;
    final codec = data['codec'] as String?;
    final level = data['level'] as int?;
    final profile = data['profile'] as String?;
    final bitRate = data['bit_rate'] as String?;
    final dar = data['dar'] as String?;
    final timeBase = data['time_base'] as String?;
    final metadata = data['metadata'] as Map<String, dynamic>?;

    return VideoResultObject(pixFormat: pixFormat, codec: codec, level: level, profile: profile, bitRate: bitRate, dar: dar, timeBase: timeBase, metadata: metadata);
  }

}

class ResultColorblindAccessibilityScore {
  double distinctEdges;
  double distinctColors;
  List<String> mostIndistinctPair;

  ResultColorblindAccessibilityScore(
      this.distinctEdges, this.distinctColors, this.mostIndistinctPair);

  factory ResultColorblindAccessibilityScore.fromJson(
      Map<String, dynamic> data) {
    final distinctEdges = data['distinct_edges'] as double;
    final distinctColors = data['distinct_colors'] as double;
    final mostIndistinctPair = (data['most_indistinct_pair'] as List<dynamic>)
        .map((value) => value.toString())
        .toList();
    return ResultColorblindAccessibilityScore(
        distinctEdges, distinctColors, mostIndistinctPair);
  }
}

class ResultResponsiveBreakpoint {
  List<ResultSingleBreakpointData> breakpoints;
  String? transformation;

  ResultResponsiveBreakpoint(this.breakpoints, this.transformation);

  factory ResultResponsiveBreakpoint.fromJson(Map<String, dynamic> data) {
    final breakpoints = (data['breakpoints'] as List<dynamic>)
        .map((value) => ResultSingleBreakpointData.fromJson(value))
        .toList();
    final transformation = data['transformation'] as String?;

    return ResultResponsiveBreakpoint(breakpoints, transformation);
  }
}

class ResultSingleBreakpointData {
  int bytes;
  int width;
  int height;
  String url;
  String secureUrl;

  ResultSingleBreakpointData(
      this.bytes, this.width, this.height, this.url, this.secureUrl);

  factory ResultSingleBreakpointData.fromJson(Map<String, dynamic> data) {
    final bytes = data['bytes'] as int;
    final width = data['width'] as int;
    final height = data['height'] as int;
    final url = data['url'] as String;
    final secureUrl = data['secure_url'] as String;
    return ResultSingleBreakpointData(bytes, width, height, url, secureUrl);
  }
}
