extension NoNullList<T> on List<T> {
  List<T> noNullList() {
    return where((element) => element != null).toList();
  }
}