import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:cloudinary_dart/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/config/cloud_config.dart';
import 'package:cloudinary_dart/src/config/url_config.dart';
import 'package:cloudinary_dart/src/analytics.dart';

import '../authtoken.dart';
import 'builders/general_asset_builder.dart';
import 'format.dart';

final String akamaiSharedCDN = "res.cloudinary.com";
final String defaultAssetType = "image";
final String defaultDeliveryType = "upload";

final String assetTypeImage = "image";
final String assetTypeVideo = "video";

class Asset extends BaseAsset {

  Asset.withConfig(super.cloudConfig, super.urlConfig) : super.withConfig();
  Asset.withBuilder(super.builder) : super.withBuilder();

//Transformation? _transformation = null;

// String getTransformationString() {
//   return _transformation.toString();
// }

// class Builder() {
//
// }
}

abstract class BaseAsset {
  //config
  CloudConfig cloudConfig;
  UrlConfig urlConfig;

  //fields
  String? version;
  String? publicId;

  Format? extension;
  String? urlSuffix;
  String assetType = defaultAssetType;
  String? deliveryType;

  BaseAsset.withConfig(this.cloudConfig, this.urlConfig);

  BaseAsset.withParameters(this.cloudConfig, this.urlConfig, this.version, this.publicId,
      this.extension,  this.urlSuffix, this.assetType, this.deliveryType);

  BaseAsset.withBuilder(GeneralAssetBuilder builder):
        cloudConfig = builder.cloudConfig,
        urlConfig = builder.urlConfig,
        version = builder.version,
        publicId = builder.publicId,
        extension = builder.extension,
        urlSuffix = builder.urlSuffix,
        assetType = builder.assetType,
        deliveryType = builder.deliveryType;

  String getTransformationString() {
    return "";
  }

  FinalizedSource finalizeSource(
      String source,
      Format? extension,
      String urlSuffix) {
    var mutableSource = source.cldMergeSlashesInUrl();
    String sourceToSign;
    if (mutableSource.cldIsHttpUrl) {
      mutableSource = mutableSource.cldSmartUrlEncode();
      sourceToSign = mutableSource;
    } else {
      mutableSource = Uri.decodeComponent(mutableSource.replaceAll("+", "%2B"))
          .cldSmartUrlEncode();
      sourceToSign = mutableSource;
      if (urlSuffix.isNotNullAndNotEmpty) {
        if (urlSuffix.contains('.') || urlSuffix.contains('/')) {
          throw ArgumentError('url_suffix should not include . or /');
        }
        mutableSource = '$mutableSource/$urlSuffix';
      }
      if(extension != null) {
        mutableSource = '$mutableSource.$extension';
        sourceToSign = '$sourceToSign.$extension';
      }
    }
    return FinalizedSource(mutableSource, sourceToSign);
  }

  String? finalizeResourceType(String? resourceType, String? type,
      String? urlSuffix, bool useRootPath, bool shorten) {
    String? mutableResourceType = resourceType ?? defaultAssetType;
    String? mutableType = type ?? defaultDeliveryType;

    if (!urlSuffix.isNullOrBlank) {
      if (mutableResourceType == 'image' && mutableType == 'upload') {
        mutableResourceType = 'images';
        mutableType = null;
      } else if (mutableResourceType == 'image' && mutableType == 'private') {
        mutableResourceType = 'private_images';
        mutableType = null;
      } else if (mutableResourceType == 'image' &&
          mutableType == 'authenticated') {
        mutableResourceType = 'authenticated_images';
        mutableType = null;
      } else if (mutableResourceType == 'raw' && mutableType == 'upload') {
        mutableResourceType = 'files';
        mutableType = null;
      } else if (mutableResourceType == 'video' && mutableType == 'upload') {
        mutableResourceType = 'videos';
        mutableType = null;
      } else {
        throw ArgumentError(
            "URL Suffix only supported for image/upload, image/private, raw/upload, image/authenticated  and video/upload");
      }
    }

    if (useRootPath) {
      if (mutableResourceType == 'image' && mutableType == 'upload' ||
          mutableResourceType == 'images' && mutableType.isNullOrBlank) {
        mutableResourceType = null;
        mutableType = null;
      } else {
        throw ArgumentError('Root path only supported for image/upload');
      }
    }

    if (shorten && mutableResourceType == "image" && mutableType == "upload") {
      mutableResourceType = 'iu';
      mutableType = null;
    }
    var result = mutableResourceType;
    if (mutableType != null) {
      result = '$result/$mutableType';
    }
    return result;
  }

  String unsignedDownloadUrlPrefix(String? cloudName, bool privateCdn,
      String? cname, bool secure, String? secureDistribution) {
    var mutableCloudName = cloudName;
    var mutableSecureDistribution = secureDistribution;
    if (mutableCloudName != null) {
      if (mutableCloudName.startsWith("/")) {
        mutableCloudName = "/res$mutableCloudName";
      }
    }
    var sharedDomain = !privateCdn;
    String prefix;
    if (secure) {
      if (mutableSecureDistribution.isNullOrBlank) {
        if (privateCdn) {
          mutableSecureDistribution = "$mutableCloudName-res.cloudinary.com";
        } else {
          mutableSecureDistribution = akamaiSharedCDN;
        }
      }
      if (!sharedDomain) {
        sharedDomain = mutableSecureDistribution == akamaiSharedCDN;
      }
      prefix = 'https://$mutableSecureDistribution';
    } else if (!cname.isNullOrBlank) {
      prefix = 'http://$cname';
    } else {
      var protocol = 'http://';
      if (privateCdn) {
        mutableCloudName = '$mutableCloudName-';
      } else {
        mutableCloudName = '';
      }
      var res = 'res';
      var domain = '.cloudinary.com';
      prefix = protocol + mutableCloudName + res + domain;
    }
    if (sharedDomain) {
      // use original cloud name here:
      prefix += '/$cloudName';
    }
    return prefix;
  }

  String? generate([String? source]) {
    var cloudName = cloudConfig.cloudName ?? "";
    if (cloudName.isBlank) {
      throw ArgumentError('Must supply cloud_name in configuration');
    }

    String? mutableSource = (source ?? publicId);
    if (mutableSource == null) {
      return null;
    }

    var httpSource = mutableSource.cldIsHttpUrl;

    if (httpSource &&
        (deliveryType.isNullOrBlank ||
            deliveryType == "asset")) {
      return mutableSource;
    }

    var signature = "";

    var finalizedSource =
        finalizeSource(mutableSource, extension, urlSuffix ?? "");

    mutableSource = finalizedSource.source;
    var sourceToSign = finalizedSource.sourceToSign;

    //Version
    var mutableVersion = version;
    if ((urlConfig.forceVersion != null && urlConfig.forceVersion == true) &&
        sourceToSign.contains('/') &&
        !sourceToSign.cldHasVersionString() &&
        !httpSource &&
        mutableVersion.isNullOrBlank) {
      mutableVersion = '1';
    }
    if (mutableVersion == null) {
      mutableVersion = '';
    } else {
      mutableVersion = 'v$mutableVersion';
    }
    //Transformation
    var transformationString = getTransformationString();

    //Signature
    if ((urlConfig.signUrl != null && urlConfig.signUrl == true) &&
        (cloudConfig.authToken == null ||
            cloudConfig.authToken == nullAutoToken)) {
      var signatureAlgorithm = "";
      if (urlConfig.longUrlSignature == true) {
        signatureAlgorithm = 'SHA-256';
      } else {
        signatureAlgorithm = cloudConfig.signatureAlgorithm;
      }
      var toSign = <String>[
        if (transformationString != null) transformationString,
        if (sourceToSign != null) sourceToSign
      ].join('/').cldRemoveStartingChars('/').cldMergeSlashesInUrl();
      (cloudConfig.apiSecret != null) ? cloudConfig.apiSecret! : "";
      var hashString = hash(toSign + cloudConfig.apiSecret!, signatureAlgorithm);
      if (hashString != null) {
        signature = base64.encode(hashString).safeBase64Encoding();
        signature =
            's--${signature.substring(0, (urlConfig.longUrlSignature != null && urlConfig.longUrlSignature == true) ? 32 : 8)}--';
      }
    }

    //Resource Type
    var finalizedResourceType = finalizeResourceType(assetType, deliveryType,
        urlSuffix, urlConfig.useRootPath ?? false, urlConfig.shorten ?? false);

    //Prefix
    var prefix = unsignedDownloadUrlPrefix(
        cloudConfig.cloudName,
        urlConfig.privateCdn ?? false,
        urlConfig.cname,
        urlConfig.secure ?? false,
        urlConfig.secureDistribution);

    //URL
    var url = <String>[
      prefix,
      finalizedResourceType ?? "",
      signature,
      transformationString,
      mutableVersion,
      mutableSource
    ].join('/').cldMergeSlashesInUrl();

    //AuthToken
    if ((urlConfig.signUrl != null && urlConfig.signUrl == true) &&
        cloudConfig.authToken != null &&
        cloudConfig.authToken != nullAutoToken) {
      var token = cloudConfig.authToken?.generate(Uri.parse(url).path);
      return '$url?$token';
    }

    //Analytics
    var urlObject = Uri.parse(url);
    if ((urlConfig.analytics != null && urlConfig.analytics == true) &&
        cloudConfig.authToken == null &&
        urlObject.query.isEmpty) {
      var analytics = '_a=${Analytics().generateAnalyticsString()}';
      return '$url?$analytics';
    }
    return url;
  }

  /// Computes hash from input string using specified algorithm.
  ///
  /// @param input              string which to compute hash from
  /// @param signatureAlgorithm algorithm to use for computing hash (supports only SHA-1 and SHA-256)
  /// @return array of bytes of computed hash value
  List<int>? hash(String input, String signatureAlgorithm) {
    Digest? result;
    var bytes = utf8.encode(input);
    if (signatureAlgorithm == "MD5") {
      result = md5.convert(bytes);
    }
    if (signatureAlgorithm == "SHA-1") {
      result = sha1.convert(bytes);
    }
    if (signatureAlgorithm == "SHA-224") {
      result = sha224.convert(bytes);
    }
    if (signatureAlgorithm == "SHA-256") {
      result = sha256.convert(bytes);
    }
    if (signatureAlgorithm == "SHA-384") {
      result = sha384.convert(bytes);
    }
    if (signatureAlgorithm == "SHA-512") {
      result = sha512.convert(bytes);
    }
    return (result != null) ? result.bytes : null;
  }
}

class FinalizedSource {
  String source;
  String sourceToSign;

  FinalizedSource(this.source, this.sourceToSign);
}
