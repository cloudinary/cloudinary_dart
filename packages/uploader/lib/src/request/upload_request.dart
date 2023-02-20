import 'package:cloudinary_dart/src/request/model/upload_options.dart';
import 'package:cloudinary_dart/uploader/abstract_uploader_request.dart';
import 'package:cloudinary_dart/uploader/uploader.dart';
import '../response/upload_result.dart';
import '../http/request/multi_part_request.dart';
import 'model/upload_params.dart';
import 'payload.dart';

class UploadRequest implements AbstractUploaderRequest<UploadResult> {
  @override
  Uploader uploader;
  UploadParams params;
  @override
  Payload<dynamic> payload;
  @override
  ProgressCallback? progressCallback;
  @override
  UploadOptions? options;
  @override
  CompletionCallback? completionCallback;

  UploadRequest(this.uploader, this.params, this.payload, {this.progressCallback, this.options, this.completionCallback});

  @override
  Map<String, dynamic> buildParams() {
    var mapParams = <String, dynamic>{};
    mapParams['public_id'] = params.publicId;
    mapParams['callback'] = params.callback;
    mapParams['format'] = params.format;
    mapParams['type'] = params.type;
    mapParams['backup'] = params.backup?.toString();
    mapParams['exif'] = params.exif?.toString();
    mapParams['faces'] = params.faces?.toString();
    mapParams['colors'] = params.colors?.toString();
    mapParams['image_metadata'] = params.imageMetadata?.toString();
    mapParams['use_filename'] = params.useFilename?.toString();
    mapParams['unique_filename'] = params.uniqueFilename?.toString();
    mapParams['eager_async'] = params.eagerAsync?.toString();
    mapParams['invalidate'] = params.invalidate?.toString();
    mapParams['overwrite'] = params.overwrite?.toString();
    mapParams['phash'] = params.phash?.toString();
    mapParams['return_delete_token'] = params.returnDeleteToken?.toString();
    mapParams['async'] = params.async?.toString();
    mapParams['notification_url'] = params.notificationUrl;
    mapParams['eager_notification_url'] = params.eagerNotificationUrl;
    mapParams['proxy'] = params.proxy;
    mapParams['folder'] = params.folder;
    // mapParams['allowed_formats'] = params.allowed_formats.join(',');
    mapParams['moderation'] = params.moderation;
    mapParams['access_mode'] = params.accessMode;
    // mapParams['responsive_breakpoints'] = params.responseBreakpoints.asResponsiveBreakpointsParam();
    mapParams['upload_preset'] = params.uploadPreset;
    // mapParams['eager'] = asEagerParam(params.eager);
    mapParams['transformation'] = params.getTransformation()?.toString();
    mapParams['signature'] = params.signature;
    mapParams['timestamp'] = params.timestamp?.toString();
    mapParams['quality_analysis'] = params.qualityAnalysis?.toString();
    mapParams['cinemagraph_analysis'] = params.cinemagraphAnalysis?.toString();
    mapParams['accessibility_analysis'] = params.accessibilityAnalysis?.toString();
    mapParams['filename_override'] = params.filenameOverride;
    mapParams.removeWhere((key, value) => value == null);
    return mapParams;
  }

  @override
  CldMultipartRequest execute()  {
    return uploader.performUpload(this);
  }


  // String asEagerParam(List<EagerTransformation> transformations) {
  //   return transformations.join("|");
  // }
}