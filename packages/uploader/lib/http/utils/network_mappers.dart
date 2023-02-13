import 'dart:convert';

abstract class RequestMapable {
  Map<String, dynamic> toJson();
}

abstract class BaseMapable<T> {
  List<dynamic> fromJson(Map<String, dynamic> json);
}

abstract class ListMapable<T> {
  Map<String, dynamic> fromJsonList(List<dynamic> json);
}
