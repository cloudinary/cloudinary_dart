import 'common.dart';

/// Transformation Builder
abstract class TransformationComponentBuilder<T> {
  Action build();
  void copyWith(T other);
}
