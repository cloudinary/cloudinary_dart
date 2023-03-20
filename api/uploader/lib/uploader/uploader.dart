import 'package:cloudinary_dart_uploader/src/request/uploader_request.dart';
import 'package:cloudinary_dart_uploader/uploader/uploader_internal.dart';
import 'package:cloudinary_dart_uploader/uploader/uploader_response.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';

import '../src/http/session/network_delegate.dart';
import '../src/http/request/multi_part_request.dart';
import '../src/request/model/uploader_params.dart';
import '../src/request/payload.dart';
import '../src/request/upload_request.dart';
import '../src/response/upload_result.dart';

class Uploader {
  Cloudinary cloudinary;
  final networkDelegate = NetworkDelegate();

  Uploader(this.cloudinary);

  // Api calls
  CldMultipartRequest? upload(dynamic file,
      {UploadParams? params,
      ProgressCallback? progressCallback,
      Map<String, String>? extraHeaders,
      CompletionCallback? completion}) {
    Payload<dynamic> payload = buildPayload(file);
    UploadRequest request = UploadRequest(
        this, params ?? UploadParams(), payload,
        progressCallback: progressCallback, completionCallback: completion);
    return request.execute();
  }

  Future<UploaderResponse<UploadResult>> uploadSync(dynamic file,
      {UploadParams? params,
      ProgressCallback? progressCallback,
      Map<String, String>? extraHeaders}) {
    Payload<dynamic> payload = buildPayload(file);
    UploadRequest request = UploadRequest(
        this, params ?? UploadParams(), payload,
        progressCallback: progressCallback);
    return request.executeSync();
  }

  Future<UploaderResponse<UploadResult>> rename(
      {required RenameParams params}) {
    UploaderRequest request = UploaderRequest('rename', this, params);
    return request.executeSync();
  }

  Future<UploaderResponse<UploadResult>> explicit(ExplicitParams params) {
    UploaderRequest request = UploaderRequest('explicit', this, params);
    return request.executeSync();
  }
}
