import 'package:cloudinary_dart/src/authtoken.dart';
import 'package:cloudinary_dart/src/cloudinary.dart';
import 'package:test/test.dart';
import 'dart:io';

import 'tests_utils.dart';
void main() {
  const key = "00112233FF99";


  group('Authtoken Tests', ()
  {
    test('Should successfully generate authtoken with start and duration', () {
      var token = AuthToken.withParameters(
          key, startTime: 1111111111, duration: 300, acl: "/image/*");
      assert("__cld_token__=st=1111111111~exp=1111111411~acl=%2fimage%2f*~hmac=1751370bcc6cfe9e03f30dd1a9722ba0f2cdca283fa3e6df3342a00a7528cc51" ==
          token.generate());
    });
    test('Should successfully generate with duration', () {
      var firstExp = (DateTime
          .now()
          .millisecondsSinceEpoch / 1000 + 300);
      sleep(Duration(milliseconds: 1200));
      String token = AuthToken.withParameters(key, acl: "*", duration: 300)
          .generate();
      sleep(Duration(milliseconds: 1200));
      var secondExp = DateTime
          .now()
          .millisecondsSinceEpoch / 1000 + 300;
      assert(true == RegExp(r'exp=(\d+)').hasMatch(token));
      var expReg = RegExp(r'exp=(\d+)').firstMatch(token);
      String? expString = expReg?.group(1);
      var actual = double.parse(expString!).round();
      print(actual);
      print(firstExp);
      print(secondExp);
      assert(actual >= firstExp);
      assert(actual <= secondExp);
      assert(token ==
          AuthToken.withParameters(key, acl: "*", expiration: actual)
              .generate());
    });
    test('Must provide Expiration or Duration error', () {
      expect(() => AuthToken.withParameters(key, acl: "*").generate(),
          throwsArgumentError);
    });
    test('Should successfully authenticated url', () {
      // cloudinary.config.urlConfig.privateCdn = true;
      // cloudinary.config.urlConfig.signUrl = true;
      var message = "should add token if authToken is globally set and signed = true";
      //TODO: Complete TESTS!!!!
    });
    test('Should successfully initializes with configuration', () {
      Cloudinary cloudinary = Cloudinary.withStringUrl(
          "cloudinary://a:b@test123?load_strategies=false&auth_token[key]=aabbcc112233&auth_token[duration]=200");
      assert(TestUtils.compareAuthToken(cloudinary.config.cloudConfig.authToken, AuthToken.withParameters("aabbcc112233", duration: 200)));
    });
    test('Should successfully generate token', () {
      var user = "foobar";
      var token = AuthToken.withParameters(
          key, duration: 300, acl: "/*/t_$user", startTime: 222222222);
      var cookieToken = token.generate();
      assert("__cld_token__=st=222222222~exp=222222522~acl=%2f*%2ft_foobar~hmac=8e39600cc18cec339b21fe2b05fcb64b98de373355f8ce732c35710d8b10259f" ==
          cookieToken);
    });
    test("Should successfully ignore url if acl is provided", () {
      var token = AuthToken.withParameters(key, duration: 300, acl: "/*/t_user", startTime: 222222222);
      var cookieToken = token.generate();
      var aclToken = AuthToken.withParameters(key, duration: 300, acl: "/*/t_user", startTime: 222222222);
      var cookieAclToken = aclToken.generate("http://res.cloudinary.com/test123/image/upload/v1486020273/sample.jpg");
      assert(cookieToken == cookieAclToken);
    });
    test('Should successfully disable analytics if token exists', () {
        //TODO: COMPLETE THIS TEST!
    });
  });
}