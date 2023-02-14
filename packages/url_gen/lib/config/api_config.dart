const String apiVersion = "v1_1";
const String defaultResourceType = "image";

const int defaultChunkSize = 20 * 1024 * 1024; // bytes
const int defaultReadTimeout = 0;
const int defaultConnectionTimeout = 60; // seconds
const String defaultUploadPrefix = "https://api.cloudinary.com";

const String uploadPrefixKey = "upload_prefix";
const String chunkSizeKey = "chunk_size";
const String readTimeoutKey = "read_timeout";
const String connectTimeoutKey = "connect_timeout";
const String callbackUrlKey = "callback_url";

abstract class IApiConfig {
  String? uploadPrefix;
  int? chunkSize;
  int? readTimeout;
  int? connectionTimeout;
  String? callbackUrl;
}

class ApiConfig implements IApiConfig {
  @override
  String? callbackUrl;

  @override
  int? chunkSize;

  @override
  int? connectionTimeout;

  @override
  int? readTimeout;

  @override
  String? uploadPrefix;

  ApiConfig(Map<String, dynamic> params) {
    uploadPrefix = params[uploadPrefixKey]?.toString() ?? defaultUploadPrefix;
    chunkSize = params[chunkSizeKey] ?? defaultChunkSize;
    readTimeout = params[readTimeoutKey] ?? defaultReadTimeout;
    connectionTimeout = params[connectTimeoutKey] ?? defaultConnectionTimeout;
    callbackUrl = params[callbackUrlKey]?.toString();
  }
}
