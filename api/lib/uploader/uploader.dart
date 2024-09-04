import 'package:cloudinary_api/src/request/uploader_request.dart';
import 'package:cloudinary_api/uploader/uploader_response.dart';
import 'package:cloudinary_api/uploader/uploader_utils.dart';
import 'package:cloudinary_api/uploader/utils.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import '../src/http/request/multi_part_request.dart';
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

  Future<UploaderResponse<UploadResult>> rename({required RenameParams params}) {
    UploaderRequest request = UploaderRequest(params);
    return _uploaderUtils.callApi<UploadResult>(
        request,
        'rename',
        options: params,
        fromJson: UploadResult.fromJson
    );
  }

  Future<UploaderResponse<UploadResult>> explicit(ExplicitParams params) {
    UploaderRequest request = UploaderRequest(params);
    return _uploaderUtils.callApi<UploadResult>(
        request,
        'explicit',
        options: params,
        fromJson: UploadResult.fromJson
    );
  }

  Future<UploaderResponse<UploadResult>> downloadBackedupAsset(DownloadBackupAssetParams params) {
    UploaderRequest request = UploaderRequest(params);
    return _uploaderUtils.callApi<UploadResult>(
        request,
        'download_backup',
        options: params,
        fromJson: UploadResult.fromJson
    );
  }

  Future<UploaderResponse<UploadResult>> destroy(DestroyParams params) {
    UploaderRequest request = UploaderRequest(params);
    return _uploaderUtils.callApi<UploadResult>(
        request,
        'destroy',
        options: params,
        fromJson: UploadResult.fromJson
    );
  }

  // Metadata management

  Future<UploaderResponse<ContextResult>> addContext(AddContextParams params) {
    params.command = ContextCommand.add.name;
    UploaderRequest request = UploaderRequest(params);
    return _uploaderUtils.callApi<ContextResult>(
        request,
        'context',
        options: params,
        fromJson: ContextResult.fromJson
    );
  }

  Future<UploaderResponse<ContextResult>> removeAllContext(RemoveAllContextParams params) {
    params.command = ContextCommand.remove_all.name;
    UploaderRequest request = UploaderRequest(params);
    return _uploaderUtils.callApi<ContextResult>(
        request,
        'context',
        options: params,
        fromJson: ContextResult.fromJson
    );
  }
}
