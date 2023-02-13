import 'dart:io';

import 'package:http/http.dart';

abstract class Payload<T> {
  late T value;
  late String name;
  late int length;
  late String path;

  Future<String> readAsString();
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
}

class StreamPayload extends Payload<ByteStream> {
  StreamPayload(ByteStream stream) {
    value = stream;
    name = 'file';
    stream.length.then((value) => length = value);
  }

  @override
  Future<String> readAsString() {
    return value.join();
  }
}