import '../common.dart';

class Dimensions {
  dynamic width;
  dynamic height;
  dynamic aspectRatio;

  Dimensions({this.width, this.height, this.aspectRatio});
}

class Resize extends Action {
  Dimensions dimensions;
  bool? relative;
  bool? regionRelative;
  String actionType;

  @override
  String toString() {
    //TODO: FIX THIS to turn to String!
    return params().toString();
  }

  List<Param?> params() {
      return [Param("c", actionType),
        Param("w", dimensions.width),
        Param("h", dimensions.height),
        (relative == true) ? Param("fl","relative") : null,
        (regionRelative == true) ? Param("fl", "region_relative") : null,
        (dimensions.aspectRatio == )

      ];
  }
}