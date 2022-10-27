import 'package:cloudinary_dart/analytics.dart';
import 'package:cloudinary_dart/asset/asset.dart';
import 'package:cloudinary_dart/asset/builders/asset_builder.dart';
import 'package:cloudinary_dart/asset/builders/image_builder.dart';
import 'package:cloudinary_dart/asset/builders/video_builder.dart';
import 'package:cloudinary_dart/cloudinary.dart';
import 'package:cloudinary_dart/config/cloudinary_config.dart';
import 'package:cloudinary_dart/config/url_config.dart';
import 'package:cloudinary_dart/src/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_dart/src/transformation/resize/resize.dart';
import 'package:cloudinary_dart/src/transformation/resize/scale.dart';
import 'package:cloudinary_dart/src/transformation/transformation.dart';
import 'package:test/test.dart';

import 'tests_utils.dart';

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
    var asset = Asset.withConfig(cloudConfig, urlConfig);
    asset.publicId = "sample";
    cldAssert('https://secure.api.com/sample', asset);
  });

  test('Should successfully generate URL with analytics', () {
    var cloudinaryWithAnalytics =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=true');
    var result = cloudinaryWithAnalytics.image('test');

    // note: This test validates the concatenation of analytics query param to the url.
    // This is not meant to test the string generation - This is tested separately in its own test.
    var expectedAnalytics = Analytics().generateAnalyticsString();
    cldAssert(
        'https://res.cloudinary.com/test123/image/upload/test?_a=$expectedAnalytics',
        result);
  });

  group('URL suffix tests', () {
    test('Test URL suffix with dot or slash successfully generated', () {
      expect(
          () => cloudinary.image(
              'publicId', ImageBuilder()..urlSuffix('dsfdfd.adsfad')),
          throwsArgumentError);
      expect(
          () => cloudinary.image(
              'publicId', ImageBuilder()..urlSuffix('dsfdfd/adsfad')),
          throwsArgumentError);
      expect(
          () => cloudinary.image(
              'publicId', ImageBuilder()..urlSuffix('dsfd.fd/adsfad')),
          throwsArgumentError);
      cldAssert(
          'https://res.cloudinary.com/test123/images/publicId/dsfdfdaddsfad',
          cloudinary.image(
              'publicId', ImageBuilder()..urlSuffix('dsfdfdaddsfad')));
    });
  });

  group('Test cloud name', () {
    test('Test valid cloud name in url', () {
      var result = cloudinary.image('test');
      cldAssert("${defaultUploadPath}test", result);
    });
    test('Test different cloud name in options ', () {
      var cloudinaryDifferentCloud =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinaryDifferentCloud.config.cloudConfig.cloudName = 'test321';
      var result = cloudinaryDifferentCloud.image('test');
      cldAssert('https://res.cloudinary.com/test321/image/upload/test', result);
    });
  });

  group('Test secure distribution', () {
    test('Test should use default secure distribution if secure is true', () {
      var cloudinarySecureFalse =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinarySecureFalse.config.urlConfig.secure = false;

      var result = cloudinarySecureFalse.image('test');
      cldAssert('http://res.cloudinary.com/test123/image/upload/test', result);

      // should take secure distribution from config if secure=TRUE
      var newConfig = cloudinary
          .config; //.copy(urlConfig = cloudinary.config.urlConfig.copy(secureDistribution = "config.secure.distribution.com"))
      newConfig.urlConfig.secureDistribution = 'config.secure.distribution.com';
      var result2 = Cloudinary.withConfiguration(newConfig).image('test');
      cldAssert(
          'https://config.secure.distribution.com/test123/image/upload/test',
          result2);
    });

    test('Test should overwrite secure distribution successfully', () {
      var cloudinarySecureDistribution =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinarySecureDistribution.config.urlConfig.secureDistribution =
          'something.else.com';

      var result = cloudinarySecureDistribution.image('test');
      cldAssert('https://something.else.com/test123/image/upload/test', result);
    });
  });

  group('Test Akamai CDN', () {
    test('Test secure true successfully produce valid URL', () {
      var cloudinarySecureWithPrivateCdn =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinarySecureWithPrivateCdn.config.urlConfig.secure = true;
      cloudinarySecureWithPrivateCdn.config.urlConfig.privateCdn = true;
      var result = cloudinarySecureWithPrivateCdn.image('test');
      cldAssert("https://test123-res.cloudinary.com/image/upload/test", result);
    });

    test('Test non Akamai CDN successfully produce valid URL', () {
      var cloudinarySecureDistribution =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinarySecureDistribution.config.urlConfig.secure = true;
      cloudinarySecureDistribution.config.urlConfig.privateCdn = true;
      cloudinarySecureDistribution.config.urlConfig.secureDistribution =
          'something.cloudfront.net';
      var result = cloudinarySecureDistribution.image('test');
      cldAssert("https://something.cloudfront.net/image/upload/test", result);
    });
  });

  test('Test private Cdn with http successfully produce valid URL', () {
    var cloudinaryWithPrivateCdn =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    cloudinaryWithPrivateCdn.config.urlConfig.privateCdn = true;
    var result = cloudinaryWithPrivateCdn.image('test');
    cldAssert("https://test123-res.cloudinary.com/image/upload/test", result);
  });

  test('Test using extension successfully produces valid URL', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result =
        cloudinary.image('test', ImageBuilder()..extension(Format.jpg));
    cldAssert("${defaultUploadPath}test.jpg", result);
  });

  test('Test successfully URL with setting delivery type', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result =
        cloudinary.image('test', ImageBuilder()..deliveryType('facebook'));
    cldAssert('https://res.cloudinary.com/test123/image/facebook/test', result);
  });

  test('Test successfully URL with setting resource type', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result = cloudinary.raw('test');
    cldAssert("https://res.cloudinary.com/test123/raw/upload/test", result);
  });

  test('Test public id with http prefix produce valid url from public id only',
      () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result = cloudinary.image('http://test');
    cldAssert('http://test', result);
    result =
        cloudinary.image('http://test', ImageBuilder()..deliveryType('asset'));
    cldAssert('http://test', result);
    result =
        cloudinary.image('http://test', ImageBuilder()..deliveryType("fetch"));
    cldAssert(
        'https://res.cloudinary.com/test123/image/fetch/http://test', result);
  });

  test('Test fetch as delivery type produce valid URL', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result = cloudinary.image(
        'http://blah.com/hello?a=b', ImageBuilder()..deliveryType("fetch"));
    cldAssert(
        'https://res.cloudinary.com/test123/image/fetch/http://blah.com/hello%3Fa%3Db',
        result);
  });

  test('Test url config with cname produce valid URL', () {
    var cloudinarySecureFalseWithCname =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    cloudinarySecureFalseWithCname.config.urlConfig.cname = 'hello.com';
    cloudinarySecureFalseWithCname.config.urlConfig.secure = false;

    var result = cloudinarySecureFalseWithCname.image('test');
    cldAssert('http://hello.com/test123/image/upload/test', result);
  });

  test('Test URL suffix with non upload delivery type throws error', () {
    expect(
        () => cloudinaryPrivateCdn.image(
            'test',
            ImageBuilder()
              ..urlSuffix('hello')
              ..deliveryType('facebook')),
        throwsArgumentError);
  });

  group('Test invalid characters in URL suffix', () {
    test('Test URL suffix with slash throws error', () {
      expect(
          () => cloudinaryPrivateCdn.image(
              'test', ImageBuilder()..urlSuffix('hello/world')),
          throwsArgumentError);
    });

    test('Test URL suffix with dot throws error', () {
      expect(
          () => cloudinaryPrivateCdn.image(
              'test', ImageBuilder()..urlSuffix('hello.world')),
          throwsArgumentError);
    });
  });

  test('Test URL suffix with private cdn produce valid URL', () {
    var actual =
        cloudinaryPrivateCdn.image('test', ImageBuilder()..urlSuffix('hello'));
    cldAssert('https://test123-res.cloudinary.com/images/test/hello', actual);

    actual = cloudinaryPrivateCdn.image(
        'test',
        ImageBuilder()
          ..urlSuffix('hello')
          ..transformation(
              (Transformation()..resize(Resize.scale(Scale()..width(100))))));
    cldAssert(
        'https://test123-res.cloudinary.com/images/c_scale,w_100/test/hello',
        actual);
  });

  test('Test URL suffix with format produce valid URL', () {
    //Show builder creation using constructor
    var actual = cloudinaryPrivateCdn.image(
        'test', ImageBuilder(urlSuffix: 'hello', extension: Format.jpg));
    cldAssert(
        'https://test123-res.cloudinary.com/images/test/hello.jpg', actual);
  });

  test('Test url suffix without sign produce valid URL', () {
    var pattern = RegExp(r's--[\dA-Za-z_-]{8}--');
    String url = cloudinarySignedUrl
        .image('test', ImageBuilder()..extension(Format.jpg))
        .toString();
    var matcher = pattern.allMatches(url);
    var expectedSignature =
        url.substring(matcher.first.start, matcher.first.end);
    var actual = cloudinaryPrivateCdnSignUrl.image(
        'test',
        ImageBuilder()
          ..urlSuffix('hello')
          ..extension(Format.jpg));
    cldAssert(
        'https://test123-res.cloudinary.com/images/$expectedSignature/test/hello.jpg',
        actual);

    url = cloudinarySignedUrl
        .image(
            'test',
            ImageBuilder()
              ..extension(Format.jpg)
              ..transformation((Transformation()..generic('a_0'))))
        .toString();
    matcher = pattern.allMatches(url);
    actual = cloudinaryPrivateCdnSignUrl.image(
        'test',
        ImageBuilder()
          ..urlSuffix('hello')
          ..extension(Format.jpg)
          ..transformation(Transformation()..generic('a_0')));
    expectedSignature = url.substring(matcher.first.start, matcher.first.end);
    cldAssert(
        'https://test123-res.cloudinary.com/images/$expectedSignature/a_0/test/hello.jpg',
        actual);
  });

  group('Test url suffix for different asset types', () {
    test('Test using url suffix for raw uploads produce valid url', () {
      var actual =
          cloudinaryPrivateCdn.raw('test', AssetBuilder()..urlSuffix('hello'));
      cldAssert('https://test123-res.cloudinary.com/files/test/hello', actual);
    });

    test('Test using url suffix for video uploads produce valid url', () {
      var actual = cloudinaryPrivateCdn.video(
          'test', VideoBuilder()..urlSuffix('hello'));
      cldAssert('https://test123-res.cloudinary.com/videos/test/hello', actual);
    });

    test('Test using url suffix for authenticated images produce valid url',
        () {
      var actual = cloudinaryPrivateCdn.image(
          'test',
          ImageBuilder()
            ..urlSuffix('hello')
            ..deliveryType('authenticated'));
      cldAssert(
          'https://test123-res.cloudinary.com/authenticated_images/test/hello',
          actual);
    });
    test('Test using url suffix for private images produce valid url', () {
      var actual = cloudinaryPrivateCdn.image(
          'test',
          ImageBuilder()
            ..urlSuffix('hello')
            ..deliveryType('private'));
      cldAssert('https://test123-res.cloudinary.com/private_images/test/hello',
          actual);
    });
  });

  group('Use root path tests', () {
    test('Test use root path with private cdn produce valid url', () {
      var actual = cloudinaryPrivateCdnUseRootPath.image('test');
      cldAssert('https://test123-res.cloudinary.com/test', actual);

      actual = cloudinaryPrivateCdnUseRootPath.image('test',
          ImageBuilder()..transformation(Transformation()..generic('a_0')));
      cldAssert('https://test123-res.cloudinary.com/a_0/test', actual);
    });

    test('Test use root path with url suffix and private cdn produce valid url',
        () {
      var actual = cloudinaryPrivateCdnUseRootPath.image(
          'test', ImageBuilder()..urlSuffix('hello'));
      cldAssert('https://test123-res.cloudinary.com/test/hello', actual);
    });

    test('test throw when use root path and facebook', () {
      expect(
          () => cloudinaryPrivateCdnUseRootPath.image(
              'test', ImageBuilder()..deliveryType('facebook')),
          throwsArgumentError);
    });

    test('test throw when use root path and raw asset type', () {
      expect(
          () => cloudinaryPrivateCdnUseRootPath.raw(
              'test', AssetBuilder()..deliveryType('facebook')),
          throwsArgumentError);
    });
  });

  test('Test http escape produce valid url', () {
    var cloudinary =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    var result = cloudinary.image('http://www.youtube.com/watch?v=d9NF2edxy-M',
        ImageBuilder()..deliveryType('youtube'));
    cldAssert(
        'https://res.cloudinary.com/test123/image/youtube/http://www.youtube.com/watch%3Fv%3Dd9NF2edxy-M',
        result);
  });

  group('Test folder', () {
    test('Test folder in public id produce valid url', () {
      var cloudinary =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      var result = cloudinary.image('folder/test');
      cldAssert('${defaultUploadPath}v1/folder/test', result);
    });

    test('Test folder with exclude version produce valid url', () {
      var cloudinaryForceVersionFalse =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      cloudinaryForceVersionFalse.config.urlConfig.forceVersion = false;
      var result = cloudinaryForceVersionFalse.image('folder/test');
      cldAssert('${defaultUploadPath}folder/test', result);

      result = cloudinaryForceVersionFalse.image(
          'folder/test', ImageBuilder()..version('1234'));
      cldAssert('${defaultUploadPath}v1234/folder/test', result);

      // should add version if no value specified for forceVersion:
      var cloudinary =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      result = cloudinary.image('folder/test');
      cldAssert('${defaultUploadPath}v1/folder/test', result);

      // should not use v1 if explicit version is passed
      result = cloudinaryForceVersionFalse.image(
          'folder/test', ImageBuilder()..version('1234'));
      cldAssert('${defaultUploadPath}v1234/folder/test', result);
    });

    test('Test folder with version produce valid url', () {
      var cloudinary =
          Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
      var result = cloudinary.image('v1234/test');
      cldAssert('${defaultUploadPath}v1234/test', result);
    });
  });

  test('test shortne enabled produce valid url', () {
    var cloudinaryShortenTrue =
        Cloudinary.withStringUrl('cloudinary://a:b@test123?analytics=false');
    cloudinaryShortenTrue.config.urlConfig.shorten = true;

    var result = cloudinaryShortenTrue.image('test');
    cldAssert('https://res.cloudinary.com/test123/iu/test', result);
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
      var result = cloudinary.image(key);
      cldAssert('$defaultUploadPath$value', result);
    });
  });

  test('Test signed url produce valid url', () {
    //TODO: Fix back to crop and change signature
    var expected =
        "${defaultUploadPath}s--p9ZnzGgi--/c_scale,h_20,w_10/v1234/image.jpg";
    var actual = cloudinarySignedUrl.image(
        'image.jpg',
        ImageBuilder()
          ..version('1234')
          ..transformation(Transformation()
            ..resize(Resize.scale(Scale()
              ..width(10)
              ..height(20)))));
    cldAssert(expected, actual);
    expected = '${defaultUploadPath}s----SjmNDA--/v1234/image.jpg';
    actual =
        cloudinarySignedUrl.image('image.jpg', ImageBuilder()..version('1234'));
    cldAssert(expected, actual);
//TODO: Fix back to crop and change signature
    expected = '${defaultUploadPath}s--p9ZnzGgi--/c_scale,h_20,w_10/image.jpg';
    actual = cloudinarySignedUrl.image(
        'image.jpg',
        ImageBuilder()
          ..transformation(Transformation()
            ..resize(Resize.scale(Scale()
              ..width(10)
              ..height(20)))));
    cldAssert(expected, actual);

    expected =
        'http://res.cloudinary.com/test123/image/upload/s--2hbrSMPO--/sample.jpg';

    actual = cloudinaryLongSignedUrl.image('sample.jpg');
    cldAssert(expected, actual);
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
