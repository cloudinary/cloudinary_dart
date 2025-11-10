import '../../common.dart';
import '../../gravity/gravity.dart';

class BaseLayerPosition {
  dynamic _offsetX;
  dynamic _offsetY;
  Gravity? _gravity;

  BaseLayerPosition offsetX(dynamic offsetX) {
    _offsetX = offsetX;
    return this;
  }

  BaseLayerPosition offsetY(dynamic offsetY) {
    _offsetY = offsetY;
    return this;
  }

  BaseLayerPosition gravity(Gravity gravity) {
    _gravity = gravity;
    return this;
  }

  BaseLayerPosition({dynamic offsetX, dynamic offsetY, Gravity? gravity}) {
    _offsetX = offsetX;
    _offsetY = offsetY;
    _gravity = gravity;
  }

  List<Param> asParams() {
    return [
      if (_offsetX != null) Param('x', _offsetX),
      if (_offsetY != null) Param('y', _offsetY),
      if (_gravity != null) Param('g', _gravity),
    ];
  }
}
