/// Emulation of Swift's complex enumeration.
///
/// Example:
///
/// class Meter<int> extends Enum<int> {
///
///  const Meter(int val) : super (val);
///
///  static const Meter HIGH = const Meter(100);
///  static const Meter MIDDLE = const Meter(50);
///  static const Meter LOW = const Meter(10);
/// }
///
/// and usage:
///
/// assert (Meter.HIGH, 100);
/// assert (Meter.HIGH is Meter);
/// Reference:
/// https://stackoverflow.com/questions/15854549/how-can-i-build-an-enum-with-dart/15854550#15854550
////
abstract class Enum<T> {
  final T _value;

  const Enum(this._value);

  T get value => _value;
}