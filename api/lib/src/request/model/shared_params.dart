class SharedParams {
  bool? unsigned;
  String? resourceType;
  String? filename;
  Map<String, String>? extraHeaders;
  int? timeout;

  SharedParams(
      {this.unsigned = false,
      this.resourceType,
      this.filename,
      this.extraHeaders,
      this.timeout});
}
