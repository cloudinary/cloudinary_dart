
import 'dart:io';

import 'package:cloudinary_dart/src/request/params/upload_params.dart';
import 'package:cloudinary_dart/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';
import 'package:test/test.dart';


void main() {
  group('Uploader Tests', () {
    test('Test Cloudinary object with uploader', () async {
      Cloudinary cloudinary = Cloudinary();
      File file = File('test/assets/sample.jpeg');
      var response = await cloudinary.uploader().upload(file, params: UploadParams(uploadPreset: "ios_sample"));
      assert(response?.data != null);
    });
  });

}