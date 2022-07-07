import 'package:cloudinary_dart/src/config/cloudinary.dart';
import 'package:cloudinary_dart/src/config/cloudinary_config.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test('Test Cloudinary with URL string', () {
      Cloudinary cloudinary = Cloudinary.withStringUrl('cloudinary://123456123456123:3Sf3FAdasa2easdFGDS3afADFS2@cloudname');
    });
    test('Config with URL', () {
      CloudinaryConfig config = CloudinaryConfig.fromUri('cloudinary://123456123456123:3Sf3FAdasa2easdFGDS3afADFS2@cloudname?shorten=true&cname=custom.domain.com');

      assert("cloudname" == config.cloudName);
      assert("123456123456123" == config.apiKey);
      assert("3Sf3FAdasa2easdFGDS3afADFS2" == config.apiSecret);
      assert("custom.domain.com" == config.cname);
      assert(true == config.shorten);
    });
  });
}
