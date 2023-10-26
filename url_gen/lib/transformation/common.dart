const defaultValuesSeparator = ':';
const defaultComponentSeparator = '/';
const paramSeparator = ',';
const paramKeyValueSeparator = '_';
const newParamSeparator = ';';

class Param {
  String key;
  dynamic value;

  Param(this.key, this.value);
}

abstract class Action {}

class GenericAction extends Action {
  String? value;

  GenericAction(this.value);

  @override
  String toString() {
    return value ?? '';
  }
}
