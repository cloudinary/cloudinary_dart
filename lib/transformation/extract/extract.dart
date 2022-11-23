import '../common.dart';

class Extract extends Action {
  static GetFrame getFrame([List<dynamic>? numbers]) {
    return GetFrame(numbers);
  }

  static GetPage getPage([List<dynamic>? numbers]) {
    return GetPage(numbers);
  }
}

class GetFrame extends Extract {
  List<dynamic> numbers = [];

  GetFrame([List<dynamic>? numbers]) {
    if (numbers != null) {
      this.numbers = numbers;
    }
  }

  GetFrame byNumber(dynamic number) {
    numbers.add(number);
    return this;
  }

  GetFrame byRange(dynamic from, dynamic to) {
    numbers.add('${(from != null) ? from : ""}-${(to != null) ? to : ""}');
    return this;
  }

  @override
  String toString() {
    return 'pg_${numbers.join(';')}';
  }
}

class GetPage extends Extract {
  List<dynamic> numbers = [];

  GetPage([List<dynamic>? numbers]) {
    if (numbers != null) {
      this.numbers = numbers;
    }
  }

  GetPage byNumber(dynamic number) {
    numbers.add(number);
    return this;
  }

  GetPage byRange(dynamic from, dynamic to) {
    numbers.add('${(from != null) ? from : ""}-${(to != null) ? to : ""}');
    return this;
  }

  @override
  String toString() {
    return 'pg_${numbers.join(';')}';
  }
}
