import 'common.dart';

class NamedTransformation extends Action {
  dynamic _name;

  NamedTransformation(dynamic name) {
    _name = name;
  }

  static name(dynamic name) => NamedTransformation(name);

  @override
  String toString() {
    return 't_$_name';
  }
}