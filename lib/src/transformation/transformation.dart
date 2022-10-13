import 'common.dart';

/// Class Transformation Builder
abstract class TransformationComponentBuilder<T> {
  Action build();
  void copyWith(T other);
}
