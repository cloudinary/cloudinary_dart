import 'package:cloudinary_dart/src/config/cloudinary_config.dart';
import 'package:cloudinary_dart/src/config/cloud_config.dart';
import 'package:cloudinary_dart/src/config/url_config.dart';
import 'package:test/test.dart';

void main() {
  group('Cloud Config Tests', () {
    test('Testing valid url succeeds', () {
      CloudinaryConfig config = CloudinaryConfig
          .fromUri('cloudinary://123456123456123:3Sf3FAdasa2easdFGDS3afADFS2@cloudname?shorten=true&cname=custom.domain.com');

      assert("cloudname" == config.cloudConfig.cloudName);
      assert("123456123456123" == config.cloudConfig.apiKey);
      assert("3Sf3FAdasa2easdFGDS3afADFS2" == config.cloudConfig.apiSecret);
      assert("custom.domain.com" == config.urlConfig.cname);
      assert(true == config.urlConfig.shorten);
    });

    test('Test cloud config using parameters', () {
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
    test('Test url config initializes with default values', () {
      var config = UrlConfig();

      assert(null == config.secureDistribution);
      assert(null == config.privateCdn);
      assert(null == config.shorten);
      assert(null == config.secureCdnSubdomain);
      assert(null == config.useRootPath);
      assert(null == config.cname);
      assert(true == config.secure);
    });

    test('Test Url valid parameters', () {
      var secureDistribution = "secure.api.com";
      var cname = "my.domain.com";

      var config = UrlConfig.withParameters(secureDistribution
          , privateCdn: true
          , shorten: true
          , secureCdnSubdomain: true
          , useRootPath: true
          , cname: cname
          , secure: true);

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
