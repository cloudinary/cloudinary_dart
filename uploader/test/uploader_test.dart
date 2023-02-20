import 'dart:io';

import 'package:cloudinary_dart/src/request/model/params/resource_type.dart';
import 'package:cloudinary_dart/src/request/model/upload_options.dart';
import 'package:cloudinary_dart/src/request/model/upload_params.dart';
import 'package:cloudinary_dart/src/response/upload_result.dart';
import 'package:cloudinary_dart/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_dart/uploader/uploader_response.dart';
import 'package:cloudinary_dart_url_gen/cloudinary.dart';
import 'package:test/test.dart';

void main() {
  group('Uploader Tests', () {
    test('Test Cloudinary upload large', () async {
      Cloudinary cloudinary = Cloudinary();
      File file = File('test/assets/temp.jpg');
      late UploaderResponse<UploadResult> result;
      cloudinary.uploader().upload(file,
          params: UploadParams(uploadPreset: "ios_sample"),
          options: UploadOptions(resourceType: ResourceType.image.name),
          progressCallback: (progress, total) {
      }, completion: (response) {
        result = response;
      });
      await Future.delayed(Duration(seconds: 10));
      expect(result.data, isNot(null));
    });
  });

  group('Uploader Tests', () {
    test('Test Cloudinary signed upload', () async {
      Cloudinary cloudinary = Cloudinary();
      File file = File('test/assets/sample.jpeg');
      late UploaderResponse<UploadResult> result;
      cloudinary.uploader().upload(file,
          params: UploadParams(unsigned: false),
          options: UploadOptions(resourceType: ResourceType.image.name),
          progressCallback: (progress, total) {
      }, completion: (response) {
        result = response;
      });
      await Future.delayed(Duration(seconds: 4));
      expect(result.data, isNot(null));
    });
  });
}
