import 'package:cloudinary_url_gen/src/extensions/string_extension.dart';
import 'package:cloudinary_url_gen/transformation/layer/position/base_layer_position.dart';
import 'package:cloudinary_url_gen/transformation/layer/position/blend_mode.dart';
import 'package:cloudinary_url_gen/transformation/layer/position/timeline.dart';
import 'package:cloudinary_url_gen/transformation/source/source.dart';
import 'package:cloudinary_url_gen/transformation/transformation_utils.dart';

import '../common.dart';

String buildLayerComponent(String sourceParamKey, Source source,
    {BaseLayerPosition? position,
    BlendMode? blendMode,
    Timeline? timeline,
    List<Param>? extras}) {
  List<Param> newList = <Param>[];
  newList.addAll(source.extraComponents());
  newList.add(Param(sourceParamKey, source.toString()));
  var sourceComponent = toComponentString(newList);

  // The extra params, alongside position and timeline-position, plus fl_layer_apply - all go in the last component:
  var splited = sourceComponent.split(',');
  splited.sort((a, b) => a.toString().compareTo(b.toString()));
  var sorted = splited.join(',');
  List<Param> lastComponent = <Param>[];
  if (extras != null) {
    lastComponent.addAll(extras);
  }
  lastComponent.add(Param('fl', 'layer_apply'));
  if (position != null) {
    lastComponent.addAll(position.asParams());
  }
  if (timeline != null) {
    if (timeline.getStartOffset() != null) {
      lastComponent.add(Param("so", timeline.getStartOffset()));
    }
    if (timeline.getDuration() != null) {
      lastComponent.add(Param("eo", timeline.getEndOffset()));
    }
    if (timeline.getEndOffset() != null) {
      lastComponent.add(Param("du", timeline.getDuration()));
    }
  }
  if (blendMode != null) {
    lastComponent.add(Param('e', blendMode));
  }
  var lastComponentString = toComponentString(lastComponent);
  return sorted.joinWithValues(
      [source.transformationObject, lastComponentString],
      separator: defaultComponentSeparator,
      actionSeparator: defaultComponentSeparator);
}
