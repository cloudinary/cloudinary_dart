import 'dart:convert';

import 'package:cloudinary_api/src/request/model/params/access_control_rule.dart';
import 'package:cloudinary_api/src/request/model/params/coordinates.dart';
import 'package:cloudinary_api/src/request/model/params/eager_transformation.dart';
import 'package:cloudinary_api/src/request/model/params/responsive_breakpoint.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';


abstract class UploadApiParams {
  bool? unsigned;
  String? resourceType;
  String? filename;
  Map<String, String>? extraHeaders;
  int? timeout;

  Map<String, dynamic> buildParams();
}

class ExplicitParams extends UploadApiParams {
  String publicId;
  UploadParams? params;

  ExplicitParams(this.publicId, {this.params});

  @override
  Map<String, dynamic> buildParams() {
    var map = params?.buildParams() ?? <String, dynamic>{};
    map.addEntries({'public_id': publicId}.entries);
    return map;
  }
}

class RenameParams extends UploadApiParams {
  String fromPublicId;
  String toPublicId;
  String? type;
  String? toType;
  bool? overwrite;
  bool? invalidate;
  String? notificationUrl;

  RenameParams(
      {required this.fromPublicId,
      required this.toPublicId,
      this.type,
      this.toType,
      this.overwrite,
      this.invalidate,
      this.notificationUrl});

  @override
  Map<String, dynamic> buildParams() {
    return {
      'from_public_id': fromPublicId,
      'to_public_id': toPublicId,
      'type': type,
      'to_type': toType,
      'overwrite': overwrite,
      'invalidate': invalidate,
      'notification_url': notificationUrl
    };
  }
}

class DestroyParams extends UploadApiParams {
  String publicId;
  String? resourceType;
  String? type;
  String? notificationUrl;
  bool? invalidate;

  DestroyParams({required this.publicId, this.resourceType, this.type, this.notificationUrl, this.invalidate});

  @override
  Map<String, dynamic> buildParams() {
    return {
      'public_id': publicId,
      'resource_type': resourceType,
      'type': type,
      'notification_url': notificationUrl,
      'invalidate': invalidate
    };
  }
}

class ContextParams extends UploadApiParams {
  List<String> publicIds;
  String? command;

  ContextParams({required this.publicIds, this.command});

  @override
  Map<String, dynamic> buildParams() {
    return {
      'public_ids': publicIds.join(','),
      'command': command
    };
  }}

class AddContextParams extends ContextParams {

  Map<String, String> context;

  String? signature;
  String? resourceType;
  String? type;

  AddContextParams({required this.context, required super.publicIds, this.resourceType, this.type, this.signature, super.command});

  @override
  Map<String, dynamic> buildParams() {
    return {
      ...super.buildParams(),
      'context': context,
      'signature': signature,
      'resource_type': resourceType,
      'type': type
    };
  }
}

class RemoveAllContextParams extends ContextParams {

  RemoveAllContextParams({required super.publicIds, super.command});

  @override
  Map<String, dynamic> buildParams() {
    return super.buildParams();
  }
}

class DownloadBackupAssetParams extends UploadApiParams {
  String assetId;
  String versionId;

  DownloadBackupAssetParams(this.assetId, this.versionId);

  @override
  Map<String, dynamic> buildParams() {
    return {
      'asset_id': assetId,
      'version_id': versionId
    };
  }
}

class UploadParams extends UploadApiParams {
  bool? backup;
  bool? exif;
  bool? faces;
  bool? colors;
  @Deprecated('Use the mediaMetadata instead.')
  bool? imageMetadata;
  bool? mediaMetadata;
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

  UploadParams(
      {this.backup,
      this.exif,
      this.faces,
      this.colors,
      @Deprecated('Use the mediaMetadata instead.')
      this.imageMetadata,
      this.mediaMetadata,
      this.useFilename,
      this.uniqueFilename,
      this.eagerAsync,
      this.invalidate,
      this.discardOriginalFilename,
      this.overwrite,
      this.phash,
      this.returnDeleteToken,
      this.async,
      this.type,
      this.uploadPreset,
      this.publicId,
      this.callback,
      this.format,
      this.notificationUrl,
      this.eagerNotificationUrl,
      this.proxy,
      this.folder,
      this.allowedFormats,
      this.moderation,
      this.cinemagraphAnalysis,
      this.qualityAnalysis,
      this.accessMode,
      this.responsiveBreakpoints,
      Transformation? transformation,
      this.eager,
      this.signature,
      this.timestamp,
      this.headers,
      this.tags,
      this.faceCoordinates,
      this.customCoordinates,
      this.context,
      this.accessControl,
      this.ocr,
      this.rawConvert,
      this.categorization,
      this.detection,
      this.similaritySearch,
      this.backgroundRemoval,
      this.autoTagging,
      this.accessibilityAnalysis,
      this.filenameOverride,
      //Internal use only params
      bool unsigned = false,
      String? resourceType,
      String? filename,
      int? timeout,
      Map<String, String>? extraHeaders}) {
    _transformation = transformation;
    super.unsigned = unsigned;
    super.resourceType = resourceType;
    super.filename = filename;
    super.extraHeaders = extraHeaders;
    super.timeout = timeout;
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
      'media_metadata': mediaMetadata,
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

  Map<String, dynamic> buildParams() {
    var mapParams = <String, dynamic>{};
    mapParams['backup'] = backup?.toString();
    mapParams['exif'] = exif?.toString();
    mapParams['faces'] = faces?.toString();
    mapParams['colors'] = colors?.toString();
    mapParams['image_metadata'] = imageMetadata?.toString();
    mapParams['media_metadata'] = mediaMetadata?.toString();
    mapParams['use_filename'] = useFilename?.toString();
    mapParams['unique_filename'] = uniqueFilename?.toString();
    mapParams['eager_async'] = eagerAsync?.toString();
    mapParams['invalidate'] = invalidate?.toString();
    mapParams['discard_original_filename'] = discardOriginalFilename;
    mapParams['overwrite'] = overwrite?.toString();
    mapParams['phash'] = phash?.toString();
    mapParams['return_delete_token'] = returnDeleteToken?.toString();
    mapParams['async'] = async?.toString();
    mapParams['type'] = type;
    mapParams['upload_preset'] = uploadPreset;
    mapParams['public_id'] = publicId;
    mapParams['callback'] = callback;
    mapParams['format'] = format;
    mapParams['notification_url'] = notificationUrl;
    mapParams['eager_notification_url'] = eagerNotificationUrl;
    mapParams['proxy'] = proxy;
    mapParams['folder'] = folder;
    mapParams['allowed_formats'] = allowedFormats?.join(',');
    mapParams['moderation'] = moderation;
    mapParams['cinemagraph_analysis'] = cinemagraphAnalysis?.toString();
    mapParams['quality_analysis'] = qualityAnalysis?.toString();
    mapParams['access_mode'] = accessMode;
    mapParams['responsive_breakpoints'] =
        _asResponsiveBreakpointsParam(responsiveBreakpoints);
    mapParams['transformation'] = getTransformation()?.toString();
    mapParams['eager'] = _asEagerParam(eager);
    mapParams['signature'] = signature;
    mapParams['timestamp'] = timestamp?.toString();
    mapParams['headers'] = headers;
    mapParams['tags'] = tags?.join(',');
    mapParams['face_coordinates'] = _asCoordinatesParam(faceCoordinates);
    mapParams['custom_coordinates'] = _asCoordinatesParam(customCoordinates);
    mapParams['context'] = _asContextParam(context);
    mapParams['access_control'] = _toAccessControlJson(accessControl);
    mapParams['ocr'] = ocr;
    mapParams['raw_convert'] = rawConvert;
    mapParams['categorization'] = categorization;
    mapParams['detection'] = detection;
    mapParams['similarity_search'] = similaritySearch;
    mapParams['background_removal'] = backgroundRemoval;
    mapParams['auto_tagging'] = autoTagging;
    mapParams['accessibility_analysis'] = accessibilityAnalysis?.toString();
    mapParams['filename_override'] = filenameOverride;
    mapParams.removeWhere((key, value) => value == null);
    return mapParams;
  }

  String? _asEagerParam(List<EagerTransformation>? transformations) {
    if (transformations == null) {
      return null;
    }
    return transformations.map((value) {
      if (value.extension != null) {
        return '${value.transformation.toString()}/${value.extension}';
      } else {
        return value.transformation.toString();
      }
    }).join('|');
  }

  String? _asCoordinatesParam(Coordinates? coordinates) {
    if (coordinates == null) {
      return null;
    }
    var rects = <String>[];
    for (int i = 0; i < coordinates.coordinates.length; i++) {
      var rect = coordinates.coordinates[i];
      rects.add(
          '${rect.x.toString()},${rect.y.toString()},${rect.width.toString()},${rect.height.toString()}');
    }
    return rects.join('|');
  }

  String? _asContextParam(Map<String, dynamic>? context) {
    if (context == null) {
      return null;
    }
    return context.entries.map((entry) {
      String contextValue;

      final value = entry.value;
      if (value is List) {
        contextValue = _encodeList(value);
      } else if (value is List<dynamic>) {
        contextValue = _encodeList(value);
      } else {
        contextValue = _cldEncodeSingleContextItem(value.toString());
      }

      return '${_cldEncodeSingleContextItem(entry.key)}=$contextValue';
    }).join('|');
  }

  String _cldEncodeSingleContextItem(String context) {
    return context.replaceAll(RegExp(r'([=|])'), r'\\$1');
  }

  String _encodeList(List<dynamic> list) {
    return list.map((item) => _cldEncodeSingleContextItem(item.toString())).join(',');
  }

  List<String>? _toAccessControlJson(List<AccessControlRule>? accessControl) {
    List<String> result = [];
    if (accessControl == null) {
      return null;
    }
    for (AccessControlRule rule in accessControl) {
      result.add(jsonEncode(rule));
    }
    return result;
  }

  List<String>? _asResponsiveBreakpointsParam(
      List<ResponsiveBreakpoint>? responsiveBreakpoints) {
    List<String> result = [];
    if (responsiveBreakpoints == null) {
      return null;
    }
    for (ResponsiveBreakpoint breakpoint in responsiveBreakpoints) {
      result.add(jsonEncode(breakpoint));
    }
    return result;
  }
}
