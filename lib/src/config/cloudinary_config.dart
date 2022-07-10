import 'package:cloudinary_dart/src/config/cloud_config.dart';
import 'package:cloudinary_dart/src/config/url_config.dart';

class CloudinaryConfig with ICloudConfig, IUrlConfig {

  CloudConfig cloudConfig;
  UrlConfig urlConfig;

  CloudinaryConfig(this.cloudConfig, this.urlConfig) {
    cloudName = cloudConfig.cloudName;
    apiKey = cloudConfig.apiKey;
    apiSecret = cloudConfig.apiSecret;

    cname = urlConfig.cname;
    secureDistribution = urlConfig.secureDistribution;
    privateCdn = urlConfig.privateCdn;
    signUrl = urlConfig.signUrl;
    longUrlSignature = urlConfig.longUrlSignature;
    shorten = urlConfig.shorten;
    secureCdnSubdomain = urlConfig.secureCdnSubdomain;
    useRootPath = urlConfig.useRootPath;
    secure = urlConfig.secure;
    forceVersion = urlConfig.forceVersion;
    signatureAlgorithm = urlConfig.signatureAlgorithm;
    analytics = urlConfig.analytics;
  }

  static CloudinaryConfig fromUri(String uri) {
    var params = _parseConfigUrl(uri);

    var cloudConfig = CloudConfig.withMap(params);
    var urlConfig = UrlConfig.withMap(params);
    return CloudinaryConfig(cloudConfig, urlConfig);
  }

  static Map<String, dynamic> _parseConfigUrl(String cloudinaryUrl) {
    if (cloudinaryUrl.isEmpty) {
      throw ArgumentError("Cloudinary url must not be blank");
    }
    if (!cloudinaryUrl.startsWith("cloudinary://")) {
      throw ArgumentError("Cloudinary url must start with 'cloudinary://");
    }

    Map<String, dynamic> params = {};
    Uri uri = Uri.parse(cloudinaryUrl);
    params['cloud_name'] = uri.host;
    uri.userInfo.split(":").asMap().forEach((index, element) {
      if (index == 0) {
        params["api_key"] = element;
      }
      if (index == 1) {
        params["api_secret"] = element;
      }
    });

    params["private_cdn"] = !uri.path.isNotEmpty;
    params["secure_distribution"] = uri.path;
    if(uri.query.isNotEmpty) {
      _updateFromQuery(params, uri.query);
    }

    return params;
  }

  static void _updateFromQuery(Map<String, dynamic> params, String query) {
    query.split('&').forEach((element) {
      var paramsPair = element.split('=');
      if(_isNestedKey(paramsPair[0])) {
        _putNestedValue(params ,paramsPair[0], paramsPair[1]);
      } else {
        params[paramsPair[0]] = paramsPair[1];
      }
    });
  }


  static bool _isNestedKey(String key) {
    return RegExp('w+[w+]').hasMatch(key);
  }

  static void _putNestedValue(Map<String, dynamic> params, String key, String value) {
    var chain = key.split('[", "]');
    var outer = params;
    var innerKey = chain[0];
    var i = 0;
    while (i < chain.length - 1) {
      Map<String, dynamic>? inner;
      if(inner == null) {
        inner = {};
        outer[innerKey] = inner;
      }
      outer = inner;
      i++;
      innerKey = chain[i];
    }
    outer[innerKey] = value;
  }


}
