import 'package:cloudinary_dart/extensions/string_extension.dart';
import 'package:cloudinary_dart/src/config/cloud_config.dart';
import 'package:cloudinary_dart/src/config/url_config.dart';

final String akamaiSharedCDN = "res.cloudinary.com";
final String defaultAssetType = "image";
final String defaultDeliveryType = "upload";

final String assetTypeImage = "image";
final String assetTypeVideo = "video";

class Asset {
  //config
  late CloudConfig cloudConfig;
  late UrlConfig urlConfig;

  //fields
  String? version = null;
  String? publicId = null;
  //Format? extension = null;
  String? urlSuffix = null;
  String assetType = defaultAssetType;
  String? deliveryType = null;
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

  //Format? extension;
  String? urlSuffix;
  String assetType = defaultAssetType;
  String? deliveryType;


  BaseAsset(this.cloudConfig, this.urlConfig, this.version,
      this.publicId, /*this.extension, */this.urlSuffix,
      this.assetType, this.deliveryType);

  String getTransformationString() {
    return "";
  }

  FinalizedSource finalizeSource(String source, /*Format? extension*/
      String urlSuffix) {
    var mutableSource = source.cldMergeSlashedInUrl();
    String sourceToSign;
    if (mutableSource.cldIsHttpUrl) {
      mutableSource = mutableSource.cldSmartUrlEncode();
      sourceToSign = mutableSource;
    } else {
      mutableSource =
          Uri.decodeComponent(mutableSource.replaceAll("+", "%2B"))
              .cldSmartUrlEncode();
      sourceToSign = mutableSource;
      if (!urlSuffix.isNotNullAndNotEmpty) {
        if (urlSuffix.contains('.') || urlSuffix.contains('/')) {
          ArgumentError('url_suffix should not include . or /');
        }
        mutableSource = '$mutableSource/$urlSuffix';
        // if(extension != null) {
        //   mutableSource = "$mutableSource.$extension"
        //   sourceToSign = "$sourceToSign.$extension"
        // }
      }
    }
    return FinalizedSource(mutableSource, sourceToSign);
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
        ((deliveryType != null && deliveryType!.isNotNullAndNotEmpty) ||
            deliveryType == "asset")) {
      return mutableSource;
    }

    var signature = "";

    var finalizedSource = finalizeSource(
        mutableSource, /* extension */, urlSuffix);

    mutableSource = finalizedSource.source;
    var sourceToSign = finalizedSource.sourceToSign;

    //Version
    var mutableVersion = version;
    if ((urlConfig.forceVersion != null && urlConfig.forceVersion == true) &&
        sourceToSign.contains('/') && !sourceToSign.cldHasVersionString()
        && !httpSource && (mutableVersion != null && mutableVersion!.isEmpty)) {
      mutableVersion = '1';
    }
    if (mutableVersion == null) {
      mutableVersion = '';
    } else {
      'v$mutableVersion';
    }

    var transformationString = getTransformationString();
    if ((urlConfig.signUrl != null && urlConfig.signUrl == true) &&
        (cloudConfig.authToken == null ||
            cloudConfig.authToken == NULL_AUTH_TOKEN)) {

    }
  }
}
class FinalizedSource {
  String source;
  String sourceToSign;

  FinalizedSource(this.source, this.sourceToSign);
}


