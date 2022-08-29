import 'package:cloudinary_dart/src/asset/asset.dart';

class Image extends BaseAsset {
  @override
  final String assetType = assetTypeImage;
  Image.withBuilder(super.builder) : super.withBuilder();
}