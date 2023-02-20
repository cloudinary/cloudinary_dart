import 'package:cloudinary_dart/src/request/model/params/access_control_rule.dart';
import 'package:cloudinary_dart/src/request/model/params/coordinates.dart';
import 'package:cloudinary_dart/src/request/model/params/eager_transformation.dart';
import 'package:cloudinary_dart/src/request/model/params/responsive_breakpoint.dart';
import 'package:cloudinary_dart_url_gen/transformation/transformation.dart';

class UploadParams {
  bool? backup;
  bool? exif;
  bool? faces;
  bool? colors;
  bool? imageMetadata;
  bool? useFilename;
  bool? uniqueFilename;
  bool? eagerAsync;
  bool? invalidate;
  bool? discardOriginalFilename;
  bool? overwrite;
  bool? phash;
  bool? returnDeleteToken;
  bool? async;
  String? type;
  String? uploadPreset;
  String? publicId;
  String? callback;
  String? format;
  String? notificationUrl;
  String? eagerNotificationUrl;
  String? proxy;
  String? folder;
  List<String>? allowedFormats;
  String? moderation;
  bool? cinemagraphAnalysis;
  bool? qualityAnalysis;

  String? accessMode;
  List<ResponsiveBreakpoint>? responsiveBreakpoints;
  Transformation? _transformation;
  List<EagerTransformation>? eager;
  String? signature;
  int? timestamp;

  String? headers;
  List<String>? tags;
  Coordinates? faceCoordinates;
  Coordinates? customCoordinates;
  Map<String, dynamic>? context;
  List<AccessControlRule>? accessControl;
  String? ocr;
  String? rawConvert;
  String? categorization;
  String? detection;
  String? similaritySearch;
  String? backgroundRemoval;
  String? autoTagging;
  bool? accessibilityAnalysis;
  String? filenameOverride;
  bool? unsigned;


  UploadParams({this.backup, this.exif, this.faces, this.colors,
    this.imageMetadata, this.useFilename, this.uniqueFilename,
    this.eagerAsync, this.invalidate, this.discardOriginalFilename,
    this.overwrite, this.phash, this.returnDeleteToken,
    this.async, this.type, this.uploadPreset, this.publicId, this.callback, this.format, this.notificationUrl, this.eagerNotificationUrl,
    this.proxy, this.folder, this.allowedFormats, this.moderation, this.cinemagraphAnalysis, this.qualityAnalysis,
    this.accessMode, this.responsiveBreakpoints, Transformation? transformation, this.eager, this.signature, this.timestamp, this.headers, this.tags,
    this.faceCoordinates, this.customCoordinates, this.context, this.accessControl, this.ocr, this.rawConvert, this.categorization,
    this.detection, this.similaritySearch, this.backgroundRemoval,
    this.autoTagging, this.accessibilityAnalysis, this.filenameOverride, this.unsigned}) {
    _transformation = transformation;
  }


  UploadParams transformation(Transformation transformation) {
    _transformation = transformation;
    return this;
  }

  Transformation? getTransformation() {
    return _transformation;
  }

  Map<String, dynamic> toJson() {
    return {
      'backup': backup,
      'exif': exif,
      'faces': faces,
      'colors': colors,
      'image_metadata': imageMetadata,
      'use_filename': useFilename,
      'unique_filename': uniqueFilename,
      'eager_async': eagerAsync,
      'invalidate': invalidate,
      'discard_original_filename': discardOriginalFilename,
      'overwrite': overwrite,
      'phash': phash,
      'return_delete_token': returnDeleteToken,
      'async': async,
      'type': type,
      'upload_preset': uploadPreset,
      'public_id': publicId,
      'callback': callback,
      'format': format,
      'notification_url': notificationUrl,
      'eager_notification_url': eagerNotificationUrl,
      'proxy': proxy,
      'folder': folder,
      'allowed_formats': allowedFormats,
      'moderation': moderation,
      'cinemagraph_analysis': cinemagraphAnalysis,
      'quality_analysis': qualityAnalysis,
      'access_mode': accessMode,
      'responsive_breakpoints': responsiveBreakpoints,
      'transformation': _transformation,
      'eager': eager,
      'signature': signature,
      'timestamp': timestamp,
      'headers': headers,
      'tags': tags,
      'face_coordinates': faceCoordinates,
      'custom_coordinates': customCoordinates,
      'context': context,
      'access_control': accessControl,
      'ocr': ocr,
      'raw_convert': rawConvert,
      'categorization': categorization,
      'detection': detection,
      'similarity_search': similaritySearch,
      'background_removal': backgroundRemoval,
      'auto_tagging': autoTagging,
      'accessibility_analysis': accessibilityAnalysis,
      'filename_override': filenameOverride,
    };
  }
}