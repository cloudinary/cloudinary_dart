import '../auth_token.dart';

const String cloudNameKey = 'cloud_name';
const String apiKeyKey = "api_key";
const String apiSecretKey = "api_secret";
const String authTokenKey = "auth_token";
const String signatureAlgorithmKey = "signature_algorithm";
const String signatureVersionKey = "signature_version";

const String defaultSignatureAlgorithm = "SHA-1";
const int defaultSignatureVersion = 2;

mixin ICloudConfig {
  String? cloudName;
  String? apiKey;
  String? apiSecret;
  String? oauthToken;
  String signatureAlgorithm = defaultSignatureAlgorithm;
  int signatureVersion = defaultSignatureVersion;
  AuthToken? authToken;
}

class CloudConfig with ICloudConfig {
  // AuthToken? authToken;
  CloudConfig(String cloudName, String apiKey, String apiSecret,
      {String? signatureAlgorithm}) {
    this.cloudName = cloudName;
    this.apiKey = apiKey;
    this.apiSecret = apiSecret;
    this.signatureAlgorithm = signatureAlgorithm ?? defaultSignatureAlgorithm;
  }
  CloudConfig.withMap(Map<String, dynamic> params) {
    cloudName = params[cloudNameKey].toString();
    apiKey = params[apiKeyKey]?.toString();
    apiSecret = params[apiSecretKey]?.toString();
    signatureAlgorithm =
        params[signatureAlgorithmKey]?.toString() ?? defaultSignatureAlgorithm;
    signatureVersion = params[signatureVersionKey] ?? defaultSignatureVersion;
    if (params[authTokenKey] != null) {
      authToken = AuthToken.fromMap(params[authTokenKey]);
    }
  }
}
