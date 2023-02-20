
import 'dart:io';

import 'package:cloudinary_dart/src/request/params/upload_options.dart';
import 'package:cloudinary_dart/src/request/params/upload_params.dart';
import 'package:cloudinary_dart/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';
import 'package:test/test.dart';


void main() {
  // group('Uploader Tests', () {
  //   test('Test Cloudinary object with uploader', () async {
  //     Cloudinary cloudinary = Cloudinary();
  //     File file = File('test/assets/sample.jpeg');
  //     var response = await cloudinary.uploader().upload(file, params: UploadParams(uploadPreset: "ios_sample"), progressCallback: (progress, total) {
  //       print("This is progress - $progress out of total - $total ");
  //     });
  //     assert(response?.data != null);
  //   });
  // });

  // group('Uploader Tests', () {
  //   test('Test Cloudinary upload large', () async {
  //     Cloudinary cloudinary = Cloudinary();
  //     File file = File('test/assets/temp.jpg');
  //     var response = await cloudinary.uploader().upload(file, params: UploadParams(uploadPreset: "ios_sample", resourceType: 'image'), progressCallback: (progress, total) {
  //       print("This is progress - $progress out of total - $total ");
  //     });
  //     assert(response?.data != null);
  //   });
  // });

  group('Uploader Tests', () {
    test('Test Cloudinary signed upload', () async {
      Cloudinary cloudinary = Cloudinary();
      File file = File('test/assets/sample.jpeg');
      var result;
      var request = cloudinary.uploader().upload(file, params: UploadParams(unsigned: false), options: UploadOptions(resourceType: 'image'), progressCallback: (progress, total) {
        print("This is progress - $progress out of total - $total ");
      }, completion: (response) {
        result = response;
      });
      await Future.delayed(Duration(seconds: 4));
      expect(result.data, isNot(null));
    });
  });
}