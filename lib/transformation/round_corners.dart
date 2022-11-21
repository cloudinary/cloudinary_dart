import 'common.dart';

class RoundCorners extends Action {
    List<dynamic> values = [];

    RoundCorners(List<dynamic> values) {
      if(values.isNotEmpty && values.length <= 4) {
        this.values = values;
      }
      ArgumentError('The values must be either "max" literal or 1 to 4 radius values.');
    }

    static RoundCorners byRadius(dynamic pixels) {
      if (pixels is List) {
        return RoundCorners(pixels);
      }
      return RoundCorners([pixels]);
    }
    static RoundCorners max() => RoundCorners(['max']);

    @override
  String toString() {
    return 'r_${values.join(defaultValuesSeparator)}';
  }
}