import 'package:cloudinary_api/src/request/uploader_request.dart';
import 'package:cloudinary_api/uploader/uploader_response.dart';
import 'package:cloudinary_api/uploader/uploader_utils.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import '../src/http/request/multi_part_request.dart';
import '../src/request/model/shared_params.dart';
import '../src/request/model/uploader_params.dart';
import '../src/request/payload.dart';
import '../src/request/upload_request.dart';
import '../src/response/upload_result.dart';

class Uploader {
  late final UploaderUtils _uploaderUtils;

  Uploader(Cloudinary cloudinary) {
    _uploaderUtils = UploaderUtils(cloudinary);
  }

  // Api calls
  Future<UploaderResponse<UploadResult>>? upload(
    dynamic file, {
    UploadParams? params,
    Map<String, String>? extraHeaders,
    ProgressCallback? progressCallback,
    CompletionCallback? completion,
  }) {
    Payload<dynamic> payload = _uploaderUtils.buildPayload(file);
    UploadRequest request = UploadRequest(
        params ?? UploadParams(), payload,
        progress: progressCallback, completionCallback: completion);
    return _uploaderUtils.performUpload(request);
  }

  Future<UploaderResponse<UploadResult>> rename(
      {required RenameParams params}) {
    UploaderRequest request = UploaderRequest(params);
    return _uploaderUtils.callApi(request, 'rename', options: SharedParams());
  }

  Future<UploaderResponse<UploadResult>> explicit(ExplicitParams params) {
    UploaderRequest request = UploaderRequest(params);
    return _uploaderUtils.callApi(request, 'explicit', options: SharedParams());
  }

  Future<UploaderResponse<UploadResult>> downloadBackup(DownloadBackupParams params) {
    UploaderRequest request = UploaderRequest(params);
    return _uploaderUtils.callApi(request, 'download_backup', options: SharedParams(), apiVersion: 'v2');
  }
}
