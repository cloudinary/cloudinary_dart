import 'dart:core';

import '../src/extensions/bool_extension.dart';

const bool defaultSecure = true;
const bool defaultForceVersion = true;
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
const String analyticsKey = "analytics";

mixin IUrlConfig {
  String? cname;
  String? secureDistribution;
  bool? privateCdn;
  bool? signUrl;
  bool? longUrlSignature;
  bool? shorten;
  bool? secureCdnSubdomain;
  bool? useRootPath;
  bool? secure = defaultSecure;
  bool? forceVersion = defaultForceVersion;
  bool? analytics = defaultAnalytics;
}

class UrlConfig with IUrlConfig {
  UrlConfig.withMap(Map<String, dynamic> params) {
    cname = (params[cnameKey] != null) ? params[cnameKey].toString() : null;
    secureDistribution = params[secureDistributionKey].toString();
    privateCdn = params[privateCdnKey];
    signUrl = params[signUrlKey];
    longUrlSignature = params[longUrlSignatureKey];
    shorten = params[shortenKey].toString().parseBool();
    secureCdnSubdomain = params[secureCdnSubdomainKey];
    useRootPath = params[useRootPathKey];
    secure = params[secureKey] ?? defaultSecure;
    forceVersion = params[forceVersionKey] ?? defaultForceVersion;
    analytics = params[analyticsKey].toString().parseBool() ?? defaultAnalytics;
  }

  UrlConfig();

  UrlConfig.withParameters(String? secureDistribution,
      {bool? privateCdn,
      bool? shorten,
      bool? secureCdnSubdomain,
      bool? useRootPath,
      String? cname,
      bool? secure = defaultSecure,
      bool? signUrl,
      bool? longUrlSignature,
      bool? forceVersion = defaultForceVersion,
      bool? analytics = defaultAnalytics}) {
    this.secureDistribution = secureDistribution;
    this.privateCdn = privateCdn;
    this.shorten = shorten;
    this.secureCdnSubdomain = secureCdnSubdomain;
    this.useRootPath = useRootPath;
    this.cname = cname;
    this.secure = secure;
    this.signUrl = signUrl;
    this.longUrlSignature = longUrlSignature;
    this.forceVersion = forceVersion;
    this.analytics = analytics;
  }
}
