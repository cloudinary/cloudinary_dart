import 'extensions/enumeration.dart';
class HttpMethod extends Enum<String> {
  const HttpMethod(String val) : super(val);

  static const HttpMethod get = HttpMethod('GET');
  static const HttpMethod post = HttpMethod('POST');
  static const HttpMethod put = HttpMethod('PUT');
  static const HttpMethod delete = HttpMethod('DELETE');
}