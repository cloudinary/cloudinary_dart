class UploadOptions {
  Map<String, String>? extraHeaders = <String, String>{};
  String? resourceType;
  String? filename;
  bool unsigned = false;

  UploadOptions(
      {this.extraHeaders, this.resourceType, this.filename, bool? unsigned}) {
    if (unsigned != null) {
      this.unsigned = unsigned;
    }
  }
}
