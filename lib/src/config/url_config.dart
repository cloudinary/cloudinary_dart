import 'dart:core';
import 'package:cloudinary_dart/extensions/bool_extension.dart';

const bool DEFAULT_PRIVATE_CDN = false;
const bool DEFAULT_CDN_SUBDOMAIN = false;
const bool DEFAULT_SHORTEN = false;
const bool DEFAULT_USE_ROOT_PATH = false;
const bool DEFAULT_SECURE = true;
const bool DEFAULT_FORCE_VERSION = true;
const bool DEFAULT_SECURE_CDN_SUBDOMAIN = false;
const bool DEFAULT_LONG_URL_SIGNATURE = false;
const bool DEFAULT_SIGN_URL = false;
const String DEFAULT_SIGNATURE_ALGORITHM = "SHA-1";
const bool DEFAULT_ANALYTICS = true;

const String SIGN_URL = "sign_url";
const String LONG_URL_SIGNATURE = "long_url_signature";
const String FORCE_VERSION = "force_version";
const String SECURE_DISTRIBUTION = "secure_distribution";
const String PRIVATE_CDN = "private_cdn";
const String CDN_SUBDOMAIN = "cdn_subdomain";
const String SHORTEN = "shorten";
const String SECURE_CDN_SUBDOMAIN = "secure_cdn_subdomain";
const String USE_ROOT_PATH = "use_root_path";
const String CNAME = "cname";
const String SECURE = "secure";
const String SIGNATURE_ALGORITHM = "signature_algorithm";
const String ANALYTICS = "analytics";

mixin IUrlConfig {
  String? cname;
  String? secureDistribution;
  bool privateCdn = DEFAULT_PRIVATE_CDN;
  bool signUrl = DEFAULT_SIGN_URL;
  bool longUrlSignature = DEFAULT_LONG_URL_SIGNATURE;
  bool shorten = DEFAULT_SHORTEN;
  bool secureCdnSubdomain = DEFAULT_SECURE_CDN_SUBDOMAIN;
  bool useRootPath = DEFAULT_USE_ROOT_PATH;
  bool secure = DEFAULT_SECURE;
  bool forceVersion = DEFAULT_FORCE_VERSION;
  String signatureAlgorithm = DEFAULT_SIGNATURE_ALGORITHM;
  bool analytics = DEFAULT_ANALYTICS;
}

class UrlConfig with IUrlConfig {
  UrlConfig.withMap(Map<String, dynamic> params) {
    cname = params[CNAME].toString();
    secureDistribution = params[SECURE_DISTRIBUTION].toString();
    privateCdn = params[PRIVATE_CDN] ?? DEFAULT_PRIVATE_CDN;
    signUrl = params[SIGN_URL] ?? DEFAULT_SIGN_URL;
    longUrlSignature = params[LONG_URL_SIGNATURE] ?? DEFAULT_LONG_URL_SIGNATURE;
    shorten = params[SHORTEN].toString().parseBool() ?? DEFAULT_SHORTEN;
    secureCdnSubdomain = params[SECURE_CDN_SUBDOMAIN] ?? DEFAULT_SECURE_CDN_SUBDOMAIN;
    useRootPath = params[USE_ROOT_PATH] ?? DEFAULT_USE_ROOT_PATH;
    secure = params[SECURE] ?? DEFAULT_SECURE;
    forceVersion = params[FORCE_VERSION] ?? DEFAULT_FORCE_VERSION;
    signatureAlgorithm = params[SIGNATURE_ALGORITHM]?.toString() ?? DEFAULT_SIGNATURE_ALGORITHM;
    analytics = params[ANALYTICS] ?? DEFAULT_ANALYTICS;
  }

  UrlConfig();

  UrlConfig.withParameters(String? secureDistribution
      , {bool? privateCdn = DEFAULT_PRIVATE_CDN
      , bool? shorten = DEFAULT_SHORTEN
      , bool? secureCdnSubdomain = DEFAULT_SECURE_CDN_SUBDOMAIN
      , bool? useRootPath = DEFAULT_USE_ROOT_PATH
      , String? cname
      , bool? secure = DEFAULT_SECURE
      , bool? signUrl = DEFAULT_SIGN_URL
      , bool? longUrlSignature = DEFAULT_LONG_URL_SIGNATURE
      , bool? forceVersion = DEFAULT_FORCE_VERSION
      , bool? analytics = DEFAULT_ANALYTICS}) {
    this.secureDistribution = secureDistribution;
    this.privateCdn = privateCdn ?? DEFAULT_PRIVATE_CDN;
    this.shorten = shorten ?? DEFAULT_SHORTEN;
    this.secureCdnSubdomain = secureCdnSubdomain ?? DEFAULT_SECURE_CDN_SUBDOMAIN;
    this.useRootPath = useRootPath ?? DEFAULT_USE_ROOT_PATH;
    this.cname = cname;
    this.secure = secure ?? DEFAULT_SECURE;
    this.signUrl = signUrl ?? DEFAULT_SIGN_URL;
    this.longUrlSignature = longUrlSignature ?? DEFAULT_LONG_URL_SIGNATURE;
    this.forceVersion = forceVersion ?? DEFAULT_FORCE_VERSION;
    this.analytics = analytics ?? DEFAULT_ANALYTICS;
  }

}