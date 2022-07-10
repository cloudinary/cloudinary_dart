import 'dart:core';
import 'package:cloudinary_dart/extensions/bool_extension.dart';

const bool defaultPrivateCdn = false;
const bool defaultCdnSubdomain = false;
const bool defaultShorten = false;
const bool defaultUseRootPath = false;
const bool defaultSecure = true;
const bool defaultForceVersion = true;
const bool defaultSecureCdnSubdomain = false;
const bool defaultLongUrlSignature = false;
const bool defaultSignUrl = false;
const String defaultSignatureAlgorithm = "SHA-1";
const bool defaultAnalytics = true;

const String signUrlKey = "sign_url";
const String longUrlSignatureKey = "long_url_signature";
const String forceVersionKey = "force_version";
const String secureDistributionKey = "secure_distribution";
const String privateCdnKey = "private_cdn";
const String cdnSubdomainKey = "cdn_subdomain";
const String shortenKey = "shorten";
const String secureCdnSubdomainKey = "secure_cdn_subdomain";
const String useRootPathKey = "use_root_path";
const String cnameKey = "cname";
const String secureKey = "secure";
const String signatureAlgorithmKey = "signature_algorithm";
const String analyticsKey = "analytics";

mixin IUrlConfig {
  String? cname;
  String? secureDistribution;
  bool privateCdn = defaultPrivateCdn;
  bool signUrl = defaultSignUrl;
  bool longUrlSignature = defaultLongUrlSignature;
  bool shorten = defaultShorten;
  bool secureCdnSubdomain = defaultSecureCdnSubdomain;
  bool useRootPath = defaultUseRootPath;
  bool secure = defaultSecure;
  bool forceVersion = defaultForceVersion;
  String signatureAlgorithm = defaultSignatureAlgorithm;
  bool analytics = defaultAnalytics;
}

class UrlConfig with IUrlConfig {
  UrlConfig.withMap(Map<String, dynamic> params) {
    cname = params[cnameKey].toString();
    secureDistribution = params[secureDistributionKey].toString();
    privateCdn = params[privateCdnKey] ?? defaultPrivateCdn;
    signUrl = params[signUrlKey] ?? defaultSignUrl;
    longUrlSignature = params[longUrlSignatureKey] ?? defaultLongUrlSignature;
    shorten = params[shortenKey].toString().parseBool() ?? defaultShorten;
    secureCdnSubdomain = params[secureCdnSubdomainKey] ?? defaultSecureCdnSubdomain;
    useRootPath = params[useRootPathKey] ?? defaultUseRootPath;
    secure = params[secureKey] ?? defaultSecure;
    forceVersion = params[forceVersionKey] ?? defaultForceVersion;
    signatureAlgorithm = params[signatureAlgorithmKey]?.toString() ?? defaultSignatureAlgorithm;
    analytics = params[analyticsKey] ?? defaultAnalytics;
  }

  UrlConfig();

  UrlConfig.withParameters(String? secureDistribution
      , {bool? privateCdn = defaultPrivateCdn
      , bool? shorten = defaultShorten
      , bool? secureCdnSubdomain = defaultSecureCdnSubdomain
      , bool? useRootPath = defaultUseRootPath
      , String? cname
      , bool? secure = defaultSecure
      , bool? signUrl = defaultSignUrl
      , bool? longUrlSignature = defaultLongUrlSignature
      , bool? forceVersion = defaultForceVersion
      , bool? analytics = defaultAnalytics}) {
    this.secureDistribution = secureDistribution;
    this.privateCdn = privateCdn ?? defaultPrivateCdn;
    this.shorten = shorten ?? defaultShorten;
    this.secureCdnSubdomain = secureCdnSubdomain ?? defaultSecureCdnSubdomain;
    this.useRootPath = useRootPath ?? defaultUseRootPath;
    this.cname = cname;
    this.secure = secure ?? defaultSecure;
    this.signUrl = signUrl ?? defaultSignUrl;
    this.longUrlSignature = longUrlSignature ?? defaultLongUrlSignature;
    this.forceVersion = forceVersion ?? defaultForceVersion;
    this.analytics = analytics ?? defaultAnalytics;
  }
}
