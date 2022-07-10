const String cloudNameKey = 'cloud_name';
const String apiKeyKey = "api_key";
const String apiSecretKey = "api_secret";
const String authTokenKey = "auth_token";

mixin ICloudConfig {
  String? cloudName;
  String? apiKey;
  String? apiSecret;
// AuthToken? authToken;
}

class CloudConfig with ICloudConfig {
  // AuthToken? authToken;
  CloudConfig(String cloudName, String apiKey, String apiSecret) {
    this.cloudName = cloudName;
    this.apiKey = apiKey;
    this.apiSecret = apiSecret;
  }
  CloudConfig.withMap(Map<String, dynamic> params) {
    cloudName = params[cloudNameKey].toString();
    apiKey = params[apiKeyKey]?.toString();
    apiSecret = params[apiSecretKey]?.toString();
  }

}

