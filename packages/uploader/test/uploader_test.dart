
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
      var response = await cloudinary.uploader().upload(file, params: UploadParams(unsigned: false), options: UploadOptions(resourceType: 'image'), progressCallback: (progress, total) {
        print("This is progress - $progress out of total - $total ");
      });
      print(response?.rawResponse);
      assert(response?.data != null);
    });
  });
  //{\"error\":{\"message\":\"Invalid Signature f4297e0a6687ca82799eed8e08b90ae2805b67ec. String to sign - 'timestamp=1676809309.162'.\"}}

}