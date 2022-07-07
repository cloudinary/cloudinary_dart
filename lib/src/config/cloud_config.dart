const String CLOUD_NAME = 'cloud_name';
const String API_KEY = "api_key";
const String API_SECRET = "api_secret";
const String AUTH_TOKEN = "auth_token";

mixin ICloudConfig {
  String? cloudName;
  String? apiKey;
  String? apiSecret;
// AuthToken? authToken;
}

class CloudConfig with ICloudConfig {
  // AuthToken? authToken;
  CloudConfig(Map<String, dynamic> params) {
    cloudName = params[CLOUD_NAME].toString();
    apiKey = params[API_KEY]?.toString();
    apiSecret = params[API_SECRET]?.toString();
  }
}

