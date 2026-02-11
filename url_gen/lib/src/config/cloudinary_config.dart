import '../../cloudinary.dart';
import '../extensions/string_extension.dart';

class CloudinaryConfig {
  CloudConfig cloudConfig;
  UrlConfig urlConfig;
  ApiConfig apiConfig;

  CloudinaryConfig._(this.cloudConfig, this.urlConfig, this.apiConfig);

  static CloudinaryConfig fromUri(String uri) {
    var params = _parseConfigUrl(uri);

    var cloudConfig = CloudConfig.withMap(params);
    var urlConfig = UrlConfig.withMap(params);
    var apiConfig = ApiConfig(params);
    return CloudinaryConfig._(cloudConfig, urlConfig, apiConfig);
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
    params[cloudNameKey] = uri.host;
    uri.userInfo.split(":").asMap().forEach((index, element) {
      if (index == 0) {
        params[apiKeyKey] = element;
      }
      if (index == 1) {
        params[apiSecretKey] = element;
      }
    });

    params[privateCdnKey] = !uri.path.isNullOrBlank;
    params[secureDistributionKey] = uri.path;
    if (uri.query.isNotEmpty) {
      _updateFromQuery(params, uri.queryParameters);
    }

    return params;
  }

  static void _updateFromQuery(
      Map<String, dynamic> params, Map<String, String> map) {
    map.forEach((key, value) {
      if (_isNestedKey(key)) {
        _putNestedValue(params, key, value);
      } else {
        params[key] = value;
      }
    });
  }

  static bool _isNestedKey(String key) {
    return RegExp(r'\w+\[\w+]').hasMatch(key);
  }

  static void _putNestedValue(
      Map<String, dynamic> params, String key, String value) {
    var chain = key.split(RegExp(r'[\[\]]+'));
    var outer = params;
    var innerKey = chain[0];
    var i = 0;
    while (i < chain.length - 2) {
      Map<String, dynamic>? inner = outer[innerKey];
      if (inner == null) {
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
