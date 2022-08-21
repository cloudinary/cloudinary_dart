import 'package:cloudinary_dart/src/authtoken.dart';
import 'dart:convert';

const String cloudNameKey = 'cloud_name';
const String apiKeyKey = "api_key";
const String apiSecretKey = "api_secret";
const String authTokenKey = "auth_token";
const String signatureAlgorithmKey = "signature_algorithm";

const String defaultSignatureAlgorithm = "SHA-1";

mixin ICloudConfig {
  String? cloudName;
  String? apiKey;
  String? apiSecret;
  String? oauthToken;
  String? signatureAlgorithm = defaultSignatureAlgorithm;
  AuthToken? authToken;
}

class CloudConfig with ICloudConfig {
  // AuthToken? authToken;
  CloudConfig(String cloudName, String apiKey, String apiSecret, {String? signatureAlgorithm}) {
    this.cloudName = cloudName;
    this.apiKey = apiKey;
    this.apiSecret = apiSecret;
    this.signatureAlgorithm = signatureAlgorithm ?? defaultSignatureAlgorithm;
  }
  CloudConfig.withMap(Map<String, dynamic> params) {
    cloudName = params[cloudNameKey].toString();
    apiKey = params[apiKeyKey]?.toString();
    apiSecret = params[apiSecretKey]?.toString();
    signatureAlgorithm = params[signatureAlgorithmKey]?.toString();
    if (params[authTokenKey] != null) {
      authToken = AuthToken.withMap(params[authTokenKey]);
    }
  }

}
