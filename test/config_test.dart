import 'package:cloudinary_dart/cloudinary.dart';
import 'package:cloudinary_dart/config/cloud_config.dart';
import 'package:cloudinary_dart/config/cloudinary_config.dart';
import 'package:cloudinary_dart/config/url_config.dart';
import 'package:test/test.dart';

void main() {
  group('Cloud Config Tests', () {
    test('Should successfully initialize cloudinary config using valid url',
        () {
      CloudinaryConfig config = CloudinaryConfig.fromUri(
          'cloudinary://123456123456123:3Sf3FAdasa2easdFGDS3afADFS2@cloudname?shorten=true&cname=custom.domain.com');

      assert("cloudname" == config.cloudConfig.cloudName);
      assert("123456123456123" == config.cloudConfig.apiKey);
      assert("3Sf3FAdasa2easdFGDS3afADFS2" == config.cloudConfig.apiSecret);
      assert("custom.domain.com" == config.urlConfig.cname);
      assert(true == config.urlConfig.shorten);
    });

    test('Should successfully initialize cloudinary with cloud name only', () {
      var cloudinary = Cloudinary.fromCloudName(cloudName: 'cloudname');
      assert("cloudname" == cloudinary.config.cloudConfig.cloudName);
    });

    test('Should successfully initialize cloudinary with cloud name and apikey only', () {
      var cloudinary = Cloudinary.fromCloudName(cloudName: 'cloudname', apiKey: "apiKey");
      assert("cloudname" == cloudinary.config.cloudConfig.cloudName);
      assert("apiKey" == cloudinary.config.cloudConfig.apiKey);
    });

    test(
        'Should successfully initializes cloudinary config using valid parameters',
        () {
      var cloudName = "my_cloud";
      var apiKey = "abcdefghijklmnop";
      var apiSecret = "1234567890";

      var config = CloudConfig(cloudName, apiKey, apiSecret);
      assert(cloudName == config.cloudName);
      assert(apiKey == config.apiKey);
      assert(apiSecret == config.apiSecret);

      var copy = config;
      copy.cloudName = "different_cloud";
      assert("different_cloud" == copy.cloudName);
      assert(apiKey == copy.apiKey);
      assert(apiSecret == copy.apiSecret);
    });
  });

  group('Url Config Tests', () {
    test('Should successfully initialize url config object with default values',
        () {
      var config = UrlConfig();

      assert(null == config.secureDistribution);
      assert(null == config.privateCdn);
      assert(null == config.shorten);
      assert(null == config.secureCdnSubdomain);
      assert(null == config.useRootPath);
      assert(null == config.cname);
      assert(true == config.secure);
    });

    test(
        'Should successfully initializes url config object with valid parameters',
        () {
      var secureDistribution = "secure.api.com";
      var cname = "my.domain.com";

      var config = UrlConfig.withParameters(secureDistribution,
          privateCdn: true,
          shorten: true,
          secureCdnSubdomain: true,
          useRootPath: true,
          cname: cname,
          secure: true);

      assert(secureDistribution == config.secureDistribution);
      assert(true == config.privateCdn);
      assert(true == config.shorten);
      assert(true == config.secureCdnSubdomain);
      assert(true == config.useRootPath);
      assert(cname == config.cname);
      assert(true == config.secure);
    });
  });
}
