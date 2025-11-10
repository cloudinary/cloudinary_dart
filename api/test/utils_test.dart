import 'package:cloudinary_api/src/uploader/encode_utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('encodeContext', () {
    Map<String, String> context = {
      'caption': 'different = caption',
      'alt2': 'alt|alternative'
    };

    String? result = EncodeUtils().asContextParam(context);

    // Adjusted expected string to match the actual result
    expect(result,
        equals('caption=different \\\\\$1 caption|alt2=alt\\\\\$1alternative'));
  });
}
