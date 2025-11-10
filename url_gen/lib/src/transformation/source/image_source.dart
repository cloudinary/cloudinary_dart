import '../../extensions/string_extension.dart';
import '../common.dart';
import '../source/source.dart';
import '../transformation.dart';

class ImageSource extends Source {
  late String _publicId;

  ImageSource(String publicId, {Transformation? transformation}) {
    _publicId = publicId;
    super.transformationObject = transformation;
  }

  @override
  String toString() {
    return _publicId.cldSmartUrlEncode();
  }

  ImageSource publicId(String publicId) {
    _publicId = publicId;
    return this;
  }

  ImageSource transformation(Transformation transformation) {
    super.transformationObject = transformation;
    return this;
  }

  @override
  List<Param> extraComponents() {
    return <Param>[];
  }
}
