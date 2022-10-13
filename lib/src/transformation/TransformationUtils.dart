import 'common.dart';

/// Turns list of parameters (key, value) to valid transformation String.
/// Receives a List of [Param] returns [String]
String toComponentString(List<Param?> params) {
  List<Param> paramsNoNull = params.whereType<Param>().toList();
  paramsNoNull.sort((a, b) => a.key.toString().compareTo(b.key.toString()));
  return paramsNoNull
      .map((e) =>
          e.value != null ? "${e.key}$paramKeyValueSeparator${e.value}" : null)
      .toList()
      .join(paramSeparator);
}
