import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:cloudinary_dart_url_gen/cloudinary.dart';

void cldAssert(String expected, dynamic actual) {
  if (expected != actual.toString()) {
    stderr.writeln("expected: $expected");
    stderr.writeln("actual  : $actual");
  }
  assert(expected == actual.toString());
}

File createTempFile() {
  File file = File('cldupload.test.');
  final size = 6 * 1024 * 1024; // 6 MB
  final random = Random();
  final data = List.generate(size, (index) => random.nextInt(256));

  // Write random data to the file
  file.writeAsBytesSync(data);
  return file;
}

bool listsAreEqual(list1, list2) {
  var i = -1;
  return list1.every((val) {
    i++;
    if (val is List && list2[i] is List) {
      return listsAreEqual(val, list2[i]);
    } else {
      return list2[i] == val;
    }
  });
}

createUploadPreset(Cloudinary cloudinary, String uploadPreset) async {
  final apiUrl = Uri.parse(
      '${cloudinary.config.apiConfig.uploadPrefix}/v1_1/${cloudinary.config.cloudConfig.cloudName}/upload_presets?unsigned=true&name=$uploadPreset');
  final response = await http.post(apiUrl, headers: <String, String>{
    'Authorization':
        'Basic ${base64UrlEncode(utf8.encode('${cloudinary.config.cloudConfig.apiKey}:${cloudinary.config.cloudConfig.apiSecret}'))}'
  });
  return response;
}
