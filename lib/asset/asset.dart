import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:cloudinary_dart/src/extensions/string_extension.dart';
import 'package:cloudinary_dart/analytics.dart';

import 'package:cloudinary_dart/auth_token.dart';
import '../config/cloud_config.dart';
import '../config/url_config.dart';
import '../transformation/transformation.dart';
import 'builders/general_asset_builder.dart';

final String akamaiSharedCDN = "res.cloudinary.com";
final String defaultAssetType = "image";
final String defaultDeliveryType = "upload";

final String assetTypeImage = "image";
final String assetTypeVideo = "video";

class Asset extends GeneralAssetBuilder {
  Asset(String publicId,
      {CloudConfig? cloudConfig,
      UrlConfig? urlConfig,
      String? version,
      String? extension,
      String? urlSuffix,
      String? assetType,
      String? deliveryType,
      TransformationObject? transformation})
      : super(cloudConfig, urlConfig, version, publicId, extension, urlSuffix,
            assetType, deliveryType, transformation) {
    super.assetType('raw');
  }

  @override
  String toString() {
    return AssetObject.withBuilder(this).toString();
  }
}

class AssetObject extends BaseAsset {
  AssetObject.withConfig(super.cloudConfig, super.urlConfig)
      : super.withConfig();
  AssetObject.withBuilder(super.builder) : super.withBuilder();

  @override
  String getTransformationString() {
    return (transformation != null) ? transformation.toString() : '';
  }

  @override
  TransformationObject? getTransformation() {
    return transformation;
  }
}

abstract class BaseAsset {
  //config
  CloudConfig cloudConfig;
  UrlConfig urlConfig;

  //fields
  String? version;
  String? publicId;

  String? extension;
  String? urlSuffix;
  String assetType = defaultAssetType;
  String? deliveryType;
  TransformationObject? transformation;

  BaseAsset.withConfig(this.cloudConfig, this.urlConfig);

  BaseAsset.withParameters(
      this.cloudConfig,
      this.urlConfig,
      this.version,
      this.publicId,
      this.extension,
      this.urlSuffix,
      this.assetType,
      this.deliveryType);

  BaseAsset.withBuilder(GeneralAssetBuilder builder)
      : cloudConfig = builder.getCloudConfig()!,
        urlConfig = builder.getUrlConfig()!,
        version = builder.getVersion(),
        publicId = builder.getPublicId(),
        extension = builder.getExtension(),
        urlSuffix = builder.getUrlSuffix(),
        assetType = builder.getAssetType() ?? defaultAssetType,
        deliveryType = builder.getDeliveryType(),
        transformation = builder.getTransformation();

  String getTransformationString();
  TransformationObject? getTransformation();

  FinalizedSource finalizeSource(
      String source, String? extension, String urlSuffix) {
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
      if (extension != null) {
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

  String _generate() {
    var cloudName = cloudConfig.cloudName ?? "";
    if (cloudName.isBlank) {
      throw ArgumentError('Must supply cloud_name in configuration');
    }

    String? mutableSource = publicId;
    if (mutableSource == null) {
      return "";
    }

    var httpSource = mutableSource.cldIsHttpUrl;

    if (httpSource && (deliveryType.isNullOrBlank || deliveryType == "asset")) {
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
      var toSign = <String>[transformationString, sourceToSign]
          .join('/')
          .cldRemoveStartingChars('/')
          .cldMergeSlashesInUrl();
      (cloudConfig.apiSecret != null) ? cloudConfig.apiSecret! : "";
      var hashString =
          hash(toSign + cloudConfig.apiSecret!, signatureAlgorithm);
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

  @override
  String toString() {
    return _generate();
  }
}

class FinalizedSource {
  String source;
  String sourceToSign;

  FinalizedSource(this.source, this.sourceToSign);
}
