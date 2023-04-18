import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Context Params', () {
    test('null context is not included in params map', () {
      // Given
      const Map<String, dynamic>? context = null;
      const expectedParamsMap = <String, dynamic>{};

      // When
      final uploadParams = UploadParams(context: context);
      final paramsMap = uploadParams.buildParams();

      // Then
      expect(paramsMap, expectedParamsMap);
    });

    test('string context param should be mapped correctly', () {
      // Given
      const context = <String, dynamic>{
        'user': 'id',
      };
      const expectedParamsMap = <String, dynamic>{
        'context': 'user=id',
      };

      // When
      final uploadParams = UploadParams(context: context);
      final paramsMap = uploadParams.buildParams();

      // Then
      expect(paramsMap, expectedParamsMap);
    });

    test('multiple context values should be joined', () {
      // Given
      const context = <String, dynamic>{
        'user': 'id',
        'claimed': false,
      };
      const expectedParamsMap = <String, dynamic>{
        'context': 'user=id|claimed=false',
      };

      // When
      final uploadParams = UploadParams(context: context);
      final paramsMap = uploadParams.buildParams();

      // Then
      expect(paramsMap, expectedParamsMap);
    });
  });
}
