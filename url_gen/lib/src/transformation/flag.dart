import 'common.dart';

class Flag {
  List<dynamic> values = [];

  Flag(this.values);

  static Flag waveform() => Flag(['waveform']);

  @override
  String toString() {
    return 'fl_${values.join(defaultValuesSeparator)}';
  }
}
