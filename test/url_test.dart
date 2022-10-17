import 'package:cloudinary_dart/analytics.dart';
import 'package:cloudinary_dart/asset/asset.dart';
import 'package:cloudinary_dart/asset/builders/asset_builder.dart';
import 'package:cloudinary_dart/asset/builders/image_builder.dart';
import 'package:cloudinary_dart/asset/builders/video_builder.dart';
import 'package:cloudinary_dart/asset/format.dart';
import 'package:cloudinary_dart/cloudinary.dart';
import 'package:cloudinary_dart/config/cloudinary_config.dart';
import 'package:cloudinary_dart/config/url_config.dart';
import 'package:test/test.dart';

const defaultRootPath = 'https://res.cloudinary.com/test123/';
const defaultUploadPath = '${defaultRootPath}image/upload/';

void main() {
  var cloudinary =
      Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');

  var cloudinaryPrivateCdn =
      Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
  cloudinaryPrivateCdn.config.urlConfig.privateCdn = true;

  var cloudinaryPrivateCdnUseRootPath =
      Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
  cloudinaryPrivateCdnUseRootPath.config.urlConfig.privateCdn = true;
  cloudinaryPrivateCdnUseRootPath.config.urlConfig.useRootPath = true;

  var cloudinaryPrivateCdnSignUrl =
      Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
  cloudinaryPrivateCdnSignUrl.config.urlConfig.privateCdn = true;
  cloudinaryPrivateCdnSignUrl.config.urlConfig.signUrl = true;

  var cloudinarySignedUrl =
      Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
  cloudinarySignedUrl.config.urlConfig.signUrl = true;

  var cloudinaryLongSignedUrl =
      Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
  cloudinaryLongSignedUrl.config.urlConfig.secure = false;
  cloudinaryLongSignedUrl.config.urlConfig.signUrl = true;
  cloudinaryLongSignedUrl.config.cloudConfig.signatureAlgorithm = 'SHA-256';

  test('Should successfully initialize config values', () {
    var urlConfig = UrlConfig.withParameters('secure.api.com',
        privateCdn: true,
        shorten: true,
        secureCdnSubdomain: true,
        useRootPath: true,
        cname: 'my.domain.org',
        secure: true,
        analytics: false);
    var cloudConfig = cloudinary.config.cloudConfig;
    assert('https://secure.api.com/sample' ==
        Asset.withConfig(cloudConfig, urlConfig).generate('sample'));
  });

  test('Should successfully generate URL with analytics', () {
    var cloudinaryWithAnalytics =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=true');
    var result = cloudinaryWithAnalytics.image().generate('test');

    // note: This test validates the concatenation of analytics query param to the url.
    // This is not meant to test the string generation - This is tested separately in its own test.
    var expectedAnalytics = Analytics().generateAnalyticsString();
    assert(
        'https://res.cloudinary.com/test123/image/upload/test?_a=$expectedAnalytics' ==
            result);
  });

  group('URL suffix tests', () {
    test('Test URL suffix with dot or slash successfully generated', () {
      expect(
          () => cloudinary
              .image(ImageBuilder()..urlSuffix = 'dsfdfd.adsfad')
              .generate('publicId'),
          throwsArgumentError);
      expect(
          () => cloudinary
              .image(ImageBuilder()..urlSuffix = 'dsfdfd/adsfad')
              .generate('publicId'),
          throwsArgumentError);
      expect(
          () => cloudinary
              .image(ImageBuilder()..urlSuffix = 'dsfd.fd/adsfad')
              .generate('publicId'),
          throwsArgumentError);
      assert(cloudinary
              .image(ImageBuilder()..urlSuffix = 'dsfdfdaddsfad')
              .generate('publicId') ==
          'https://res.cloudinary.com/test123/images/publicId/dsfdfdaddsfad');
    });
  });

  group('Test cloud name', () {
    test('Test valid cloud name in url', () {
      var result = cloudinary.image().generate('test');
      assert("${defaultUploadPath}test" == result);
    });
    test('Test different cloud name in options ', () {
      var cloudinaryDifferentCloud =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinaryDifferentCloud.config.cloudConfig.cloudName = 'test321';
      var result = cloudinaryDifferentCloud.image().generate('test');
      assert('https://res.cloudinary.com/test321/image/upload/test' == result);
    });
  });

  group('Test secure distribution', () {
    test('Test should use default secure distribution if secure is true', () {
      var cloudinarySecureFalse =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinarySecureFalse.config.urlConfig.secure = false;

      var result = cloudinarySecureFalse.image().generate('test');
      assert('http://res.cloudinary.com/test123/image/upload/test' == result);

      // should take secure distribution from config if secure=TRUE
      var newConfig = cloudinary
          .config; //.copy(urlConfig = cloudinary.config.urlConfig.copy(secureDistribution = "config.secure.distribution.com"))
      newConfig.urlConfig.secureDistribution = 'config.secure.distribution.com';
      var result2 =
          Cloudinary.withConfiguration(newConfig).image().generate('test');
      assert(
          'https://config.secure.distribution.com/test123/image/upload/test' ==
              result2);
    });

    test('Test should overwrite secure distribution successfully', () {
      var cloudinarySecureDistribution =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinarySecureDistribution.config.urlConfig.secureDistribution =
          'something.else.com';

      var result = cloudinarySecureDistribution.image().generate('test');
      assert('https://something.else.com/test123/image/upload/test' == result);
    });
  });

  group('Test Akamai CDN', () {
    test('Test secure true successfully produce valid URL', () {
      var cloudinarySecureWithPrivateCdn =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinarySecureWithPrivateCdn.config.urlConfig.secure = true;
      cloudinarySecureWithPrivateCdn.config.urlConfig.privateCdn = true;
      var result = cloudinarySecureWithPrivateCdn.image().generate('test');
      assert("https://test123-res.cloudinary.com/image/upload/test" == result);
    });

    test('Test non Akamai CDN successfully produce valid URL', () {
      var cloudinarySecureDistribution =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinarySecureDistribution.config.urlConfig.secure = true;
      cloudinarySecureDistribution.config.urlConfig.privateCdn = true;
      cloudinarySecureDistribution.config.urlConfig.secureDistribution =
          'something.cloudfront.net';
      var result = cloudinarySecureDistribution.image().generate('test');
      assert("https://something.cloudfront.net/image/upload/test" == result);
    });
  });

  test('Test private Cdn with http successfully produce valid URL', () {
    var cloudinaryWithPrivateCdn =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    cloudinaryWithPrivateCdn.config.urlConfig.privateCdn = true;
    var result = cloudinaryWithPrivateCdn.image().generate('test');
    assert("https://test123-res.cloudinary.com/image/upload/test" == result);
  });

  test('Test using extension successfully produces valid URL', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result = cloudinary
        .image(ImageBuilder()..extension = Format.jpg())
        .generate('test');
    assert("${defaultUploadPath}test.jpg" == result);
  });

  test('Test successfully URL with setting delivery type', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result = cloudinary
        .image(ImageBuilder()..deliveryType = 'facebook')
        .generate('test');
    assert('https://res.cloudinary.com/test123/image/facebook/test' == result);
  });

  test('Test successfully URL with setting resource type', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result = cloudinary.raw().generate('test');
    assert("https://res.cloudinary.com/test123/raw/upload/test" == result);
  });

  test('Test public id with http prefix produce valid url from public id only',
      () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result = cloudinary.image().generate('http://test');
    assert('http://test' == result);
    result = cloudinary
        .image(ImageBuilder()..deliveryType = 'asset')
        .generate('http://test');
    assert('http://test' == result);
    result = cloudinary
        .image(ImageBuilder()..deliveryType = "fetch")
        .generate('http://test');
    assert(
        'https://res.cloudinary.com/test123/image/fetch/http://test' == result);
  });

  test('Test fetch as delivery type produce valid URL', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result = cloudinary
        .image(ImageBuilder()..deliveryType = "fetch")
        .generate('http://blah.com/hello?a=b');
    assert(
        'https://res.cloudinary.com/test123/image/fetch/http://blah.com/hello%3Fa%3Db' ==
            result);
  });

  test('Test url config with cname produce valid URL', () {
    var cloudinarySecureFalseWithCname =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    cloudinarySecureFalseWithCname.config.urlConfig.cname = 'hello.com';
    cloudinarySecureFalseWithCname.config.urlConfig.secure = false;

    var result = cloudinarySecureFalseWithCname.image().generate('test');
    assert('http://hello.com/test123/image/upload/test' == result);
  });

  test('Test URL suffix with non upload delivery type throws error', () {
    expect(
        () => cloudinaryPrivateCdn
            .image(ImageBuilder()
              ..urlSuffix = 'hello'
              ..deliveryType = 'facebook')
            .generate('test'),
        throwsArgumentError);
  });

  group('Test invalid characters in URL suffix', () {
    test('Test URL suffix with slash throws error', () {
      expect(
          () => cloudinaryPrivateCdn
              .image(ImageBuilder()..urlSuffix = 'hello/world')
              .generate('test'),
          throwsArgumentError);
    });

    test('Test URL suffix with dot throws error', () {
      expect(
          () => cloudinaryPrivateCdn
              .image(ImageBuilder()..urlSuffix = 'hello.world')
              .generate('test'),
          throwsArgumentError);
    });
  });

  test('Test URL suffix with private cdn produce valid URL', () {
    var actual = cloudinaryPrivateCdn
        .image(ImageBuilder()..urlSuffix = 'hello')
        .generate('test');
    assert('https://test123-res.cloudinary.com/images/test/hello' == actual);

    actual = cloudinaryPrivateCdn
        .image(ImageBuilder()
          ..urlSuffix = 'hello'
          ..transformation = 'a_0')
        .generate('test');
    assert(
        'https://test123-res.cloudinary.com/images/a_0/test/hello' == actual);
  });

  test('Test URL suffix with format produce valid URL', () {
    //Show builder creation using constructor
    var actual = cloudinaryPrivateCdn
        .image(ImageBuilder(urlSuffix: 'hello', extension: Format.jpg()))
        .generate('test');
    assert(
        'https://test123-res.cloudinary.com/images/test/hello.jpg' == actual);
  });

  test('Test url suffix without sign produce valid URL', () {
    var pattern = RegExp(r's--[\dA-Za-z_-]{8}--');
    String url = cloudinarySignedUrl
        .image(ImageBuilder()..extension = Format.jpg())
        .generate('test')!;
    var matcher = pattern.allMatches(url);
    var expectedSignature =
        url.substring(matcher.first.start, matcher.first.end);
    var actual = cloudinaryPrivateCdnSignUrl
        .image(ImageBuilder()
          ..urlSuffix = 'hello'
          ..extension = Format.jpg())
        .generate('test');
    assert(
        'https://test123-res.cloudinary.com/images/$expectedSignature/test/hello.jpg' ==
            actual);

    url = cloudinarySignedUrl
        .image(ImageBuilder()
          ..extension = Format.jpg()
          ..transformation = 'a_0')
        .generate('test')!;
    matcher = pattern.allMatches(url);
    actual = cloudinaryPrivateCdnSignUrl
        .image(ImageBuilder()
          ..urlSuffix = 'hello'
          ..extension = Format.jpg()
          ..transformation = 'a_0')
        .generate('test');
    expectedSignature = url.substring(matcher.first.start, matcher.first.end);
    assert(
        'https://test123-res.cloudinary.com/images/$expectedSignature/a_0/test/hello.jpg' ==
            actual);
  });

  group('Test url suffix for different asset types', () {
    test('Test using url suffix for raw uploads produce valid url', () {
      var actual = cloudinaryPrivateCdn
          .raw(AssetBuilder()..urlSuffix = 'hello')
          .generate('test');
      assert('https://test123-res.cloudinary.com/files/test/hello' == actual);
    });

    test('Test using url suffix for video uploads produce valid url', () {
      var actual = cloudinaryPrivateCdn
          .video(VideoBuilder()..urlSuffix = 'hello')
          .generate('test');
      assert('https://test123-res.cloudinary.com/videos/test/hello' == actual);
    });

    test('Test using url suffix for authenticated images produce valid url',
        () {
      var actual = cloudinaryPrivateCdn
          .image(ImageBuilder()
            ..urlSuffix = 'hello'
            ..deliveryType = 'authenticated')
          .generate('test');
      assert(
          'https://test123-res.cloudinary.com/authenticated_images/test/hello' ==
              actual);
    });
    test('Test using url suffix for private images produce valid url', () {
      var actual = cloudinaryPrivateCdn
          .image(ImageBuilder()
            ..urlSuffix = 'hello'
            ..deliveryType = 'private')
          .generate('test');
      assert('https://test123-res.cloudinary.com/private_images/test/hello' ==
          actual);
    });
  });

  group('Use root path tests', () {
    test('Test use root path with private cdn produce valid url', () {
      var actual = cloudinaryPrivateCdnUseRootPath.image().generate('test');
      assert('https://test123-res.cloudinary.com/test' == actual);

      actual = cloudinaryPrivateCdnUseRootPath
          .image(ImageBuilder()..transformation = 'a_0')
          .generate('test');
      assert('https://test123-res.cloudinary.com/a_0/test' == actual);
    });

    test('Test use root path with url suffix and private cdn produce valid url',
        () {
      var actual = cloudinaryPrivateCdnUseRootPath
          .image(ImageBuilder()..urlSuffix = 'hello')
          .generate('test');
      assert('https://test123-res.cloudinary.com/test/hello' == actual);
    });

    test('test throw when use root path and facebook', () {
      expect(
          () => cloudinaryPrivateCdnUseRootPath
              .image(ImageBuilder()..deliveryType = 'facebook')
              .generate('test'),
          throwsArgumentError);
    });

    test('test throw when use root path and raw asset type', () {
      expect(
          () => cloudinaryPrivateCdnUseRootPath
              .raw(AssetBuilder()..deliveryType = 'facebook')
              .generate('test'),
          throwsArgumentError);
    });
  });

  test('Test http escape produce valid url', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result = cloudinary
        .image(ImageBuilder()..deliveryType = 'youtube')
        .generate('http://www.youtube.com/watch?v=d9NF2edxy-M');
    assert(
        'https://res.cloudinary.com/test123/image/youtube/http://www.youtube.com/watch%3Fv%3Dd9NF2edxy-M' ==
            result);
  });

  group('Test folder', () {
    test('Test folder in public id produce valid url', () {
      var cloudinary =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      var result = cloudinary.image().generate('folder/test');
      assert('${defaultUploadPath}v1/folder/test' == result);
    });

    test('Test folder with exclude version produce valid url', () {
      var cloudinaryForceVersionFalse =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinaryForceVersionFalse.config.urlConfig.forceVersion = false;
      var result = cloudinaryForceVersionFalse.image().generate('folder/test');
      assert('${defaultUploadPath}folder/test' == result);

      result = cloudinaryForceVersionFalse
          .image(ImageBuilder()..version = '1234')
          .generate('folder/test');
      assert('${defaultUploadPath}v1234/folder/test' == result);

      // should add version if no value specified for forceVersion:
      var cloudinary =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      result = cloudinary.image().generate('folder/test');
      assert('${defaultUploadPath}v1/folder/test' == result);

      // should not use v1 if explicit version is passed
      result = cloudinaryForceVersionFalse
          .image(ImageBuilder()..version = '1234')
          .generate('folder/test');
      assert('${defaultUploadPath}v1234/folder/test' == result);
    });

    test('Test folder with version produce valid url', () {
      var cloudinary =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      var result = cloudinary.image().generate('v1234/test');
      assert('${defaultUploadPath}v1234/test' == result);
    });
  });

  test('test shortne enabled produce valid url', () {
    var cloudinaryShortenTrue =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    cloudinaryShortenTrue.config.urlConfig.shorten = true;

    var result = cloudinaryShortenTrue.image().generate('test');
    assert('https://res.cloudinary.com/test123/iu/test' == result);
  });

  test('Test escape in public id produce valid url', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var publicIdsToTest = {
      'a b': 'a%20b',
      'a+b': 'a%2Bb',
      'a%2Bb': 'a%2Bb',
      'a-b': 'a-b',
      'a??b': 'a%3F%3Fb'
    };
    publicIdsToTest.forEach((key, value) {
      var result = cloudinary.image().generate(key);
      assert("$defaultUploadPath$value" == result);
    });
  });

  test('Test signed url produce valid url', () {
    var expected =
        "${defaultUploadPath}s--Ai4Znfl3--/c_crop,h_20,w_10/v1234/image.jpg";
    var actual = cloudinarySignedUrl
        .image(ImageBuilder()
          ..version = '1234'
          ..transformation = 'c_crop,h_20,w_10')
        .generate('image.jpg');
    assert(expected == actual);

    expected = '${defaultUploadPath}s----SjmNDA--/v1234/image.jpg';
    actual = cloudinarySignedUrl
        .image(ImageBuilder()..version = '1234')
        .generate('image.jpg');
    assert(expected == actual);

    expected = '${defaultUploadPath}s--Ai4Znfl3--/c_crop,h_20,w_10/image.jpg';
    actual = cloudinarySignedUrl
        .image(ImageBuilder()..transformation = 'c_crop,h_20,w_10')
        .generate('image.jpg');
    assert(expected == actual);

    expected =
        'http://res.cloudinary.com/test123/image/upload/s--2hbrSMPO--/sample.jpg';

    actual = cloudinaryLongSignedUrl.image().generate('sample.jpg');
    assert(expected == actual);
  });

  group('Scheme tests', () {
    test('Cloudinary url valid scheme success', () {
      var cloudinaryUrl =
          'cloudinary://123456789012345:ALKJdjklLJAjhkKJ45hBK92baj3@test';
      CloudinaryConfig.fromUri(cloudinaryUrl);
    });

    test('Test cloudinary URL with invalid scheme throws', () {
      var cloudinaryUrl =
          'https://123456789012345:ALKJdjklLJAjhkKJ45hBK92baj3@test';
      expect(
          () => CloudinaryConfig.fromUri(cloudinaryUrl), throwsArgumentError);
    });

    test('Test cloudinary URL empty scheme', () {
      var cloudinaryUrl = '';
      expect(
          () => CloudinaryConfig.fromUri(cloudinaryUrl), throwsArgumentError);
    });
  });
}
