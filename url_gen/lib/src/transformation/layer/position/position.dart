import 'package:cloudinary_url_g../transformation/layer/position/base_layer_position.dart';

import '../../common.dart';

class Position extends BaseLayerPosition {
  bool? _tiled;
  bool _allowOverflow = true;

  Position tiled(bool tiled) {
    _tiled = tiled;
    return this;
  }

  Position allowOverflow(bool allowOverflow) {
    _allowOverflow = allowOverflow;
    return this;
  }

  @override
  List<Param> asParams() {
    var params = super.asParams();
    if (_tiled != null && _tiled == true) params.add(Param('fl', 'tiled'));
    if (!_allowOverflow) params.add(Param('fl', 'no_overflow'));
    return params;
  }
}
