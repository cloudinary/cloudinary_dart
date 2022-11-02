import 'package:cloudinary_dart/src/transformation/resize/scale.dart';

/// Class Fit
class Fit extends BaseScale {
  @override
  String actionType = "fit";
}

/// Class LimitFit
class LimitFit extends BaseScale {
  @override
  String actionType = "limit";
}

/// Class MinimumFit
class MinimumFit extends BaseScale {
  @override
  String actionType = "mfit";
}
