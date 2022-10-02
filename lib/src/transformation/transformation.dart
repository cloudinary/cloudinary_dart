import 'common.dart';

abstract class TransformationComponentBuilder<T> {
  Action build();
  void copyWith(T other);
}
