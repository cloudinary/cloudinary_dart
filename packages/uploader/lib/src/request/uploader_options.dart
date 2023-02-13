class UploaderOptions {
  Map<String, String>? headers = {};
  String? resourceType;
  String? filename;
  int? chunkSize;
  bool? unsigned;

  UploaderOptions({this.headers, this.resourceType, this.filename, this.chunkSize, this.unsigned});
}