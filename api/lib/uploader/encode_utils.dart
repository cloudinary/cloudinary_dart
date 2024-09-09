import 'dart:convert';

import 'package:cloudinary_api/src/request/model/params/coordinates.dart';
import 'package:cloudinary_api/src/request/model/params/eager_transformation.dart';
import 'package:cloudinary_api/src/request/model/params/responsive_breakpoint.dart';
import 'package:cloudinary_api/src/request/model/params/access_control_rule.dart';

class EncodeUtils {
  EncodeUtils._privateConstructor();

  static final EncodeUtils _instance = EncodeUtils._privateConstructor();

  factory EncodeUtils() {
    return _instance;
  }

  String? asEagerParam(List<EagerTransformation>? transformations) {
    if (transformations == null) {
      return null;
    }
    return transformations.map((value) {
      if (value.extension != null) {
        return '${value.transformation.toString()}/${value.extension}';
      } else {
        return value.transformation.toString();
      }
    }).join('|');
  }

  String? asCoordinatesParam(Coordinates? coordinates) {
    if (coordinates == null) {
      return null;
    }
    var rects = <String>[];
    for (int i = 0; i < coordinates.coordinates.length; i++) {
      var rect = coordinates.coordinates[i];
      rects.add(
          '${rect.x.toString()},${rect.y.toString()},${rect.width.toString()},${rect.height.toString()}');
    }
    return rects.join('|');
  }

  String? asContextParam(Map<String, dynamic>? context) {
    if (context == null) {
      return null;
    }
    return context.entries.map((entry) {
      String contextValue;

      final value = entry.value;
      if (value is List) {
        contextValue = _encodeList(value);
      } else if (value is List<dynamic>) {
        contextValue = _encodeList(value);
      } else {
        contextValue = _cldEncodeSingleContextItem(value.toString());
      }

      return '${_cldEncodeSingleContextItem(entry.key)}=$contextValue';
    }).join('|');
  }

  String _cldEncodeSingleContextItem(String context) {
    return context.replaceAll(RegExp(r'([=|])'), r'\\$1');
  }

  String _encodeList(List<dynamic> list) {
    return list
        .map((item) => _cldEncodeSingleContextItem(item.toString()))
        .join(',');
  }

  List<String>? toAccessControlJson(List<AccessControlRule>? accessControl) {
    List<String> result = [];
    if (accessControl == null) {
      return null;
    }
    for (AccessControlRule rule in accessControl) {
      result.add(jsonEncode(rule));
    }
    return result;
  }

  List<String>? asResponsiveBreakpointsParam(
      List<ResponsiveBreakpoint>? responsiveBreakpoints) {
    List<String> result = [];
    if (responsiveBreakpoints == null) {
      return null;
    }
    for (ResponsiveBreakpoint breakpoint in responsiveBreakpoints) {
      result.add(jsonEncode(breakpoint));
    }
    return result;
  }
}
