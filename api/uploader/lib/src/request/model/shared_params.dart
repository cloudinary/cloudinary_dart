class SharedParams {
  bool? unsigned;
  String? resourceType;
  String? filename;
  Map<String, String>? extraHeaders;

  SharedParams(
      {this.unsigned = false,
      this.resourceType,
      this.filename,
      this.extraHeaders});
}
