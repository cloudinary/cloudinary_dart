import 'dart:io';

abstract class Payload<T> {
  late T value;
  late String name;
  late int length;
  late String path;

  Future<String> readAsString();
  Stream<dynamic> readAsStream();
}

class FilePayload extends Payload<File> {
  FilePayload(File newValue) {
    value = newValue;
    length = newValue.lengthSync();
    name = newValue.uri.pathSegments.last;
    path = newValue.path;
  }

  @override
  Future<String> readAsString() {
    return value.readAsString();
  }

  @override
  Stream<List<int>> readAsStream() {
    return value.openRead();
  }
}

class UrlPayload extends Payload<String> {
  UrlPayload(String newValue) {
    value = newValue;
    length = -1;
  }

  @override
  Future<String> readAsString() {
    throw ArgumentError("Remote url doesn't not support input streams");
  }

  @override
  Stream<File> readAsStream() {
    throw ArgumentError("Remote url doesn't not support input streams");
  }
}

class StreamPayload extends Payload<Stream> {
  StreamPayload(Stream stream) {
    value = stream;
    name = 'file';
    stream.length.then((value) => length = value);
  }

  @override
  Future<String> readAsString() {
    return value.join();
  }

  @override
  Stream<dynamic> readAsStream() {
    return value!;
  }
}
