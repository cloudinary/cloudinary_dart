import 'dart:io';
import 'dart:math';

import 'package:cloudinary_api/src/request/model/params/access_control_rule.dart';
import 'package:cloudinary_api/src/request/model/params/coordinates.dart';
import 'package:cloudinary_api/src/request/model/params/eager_transformation.dart';
import 'package:cloudinary_api/src/request/model/params/resource_type.dart';
import 'package:cloudinary_api/src/request/model/params/responsive_breakpoint.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:cloudinary_api/src/response/upload_result.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_api/uploader/uploader_response.dart';
import 'package:cloudinary_api/uploader/utils.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_url_gen/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_url_gen/transformation/effect/effect.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:cloudinary_url_gen/util/environment.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

const remoteTestImageUrlString = 'http://cloudinary.com/images/old_logo.png';

String suffix = Environment.getEnvVariable('TRAVIS_JOB_ID') ??
    Random().nextInt(99999).toString();

String _contextTag = "context_tag_$suffix";
String _sdkTestTag = "cloudinary_dart_test_$suffix";
String _archiveTag = "${_sdkTestTag}_archive";
String _uploaderTag = "${_sdkTestTag}_uploader";
List<String> defaultTags = [_sdkTestTag, _uploaderTag];

const srcTestImageW = 241;
const srcTestImageH = 51;
const uploadPreset = 'sdk-test-upload-preset';

var cloudinary = Cloudinary();

File srcTestImage = File('test/assets/old_logo.png');
var srcTestVideo = 'https://res.cloudinary.com/demo/video/upload/dog.mp4';

void main() {
  setUpAll(() {
    if (cloudinary.config.cloudConfig.apiSecret == null) {
      throw ArgumentError('Please setup environment for Upload test to run');
    }

    createUploadPreset(cloudinary, uploadPreset);

    var setupTags = <String>[_sdkTestTag, _uploaderTag, _archiveTag];

    cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(resourceType: ResourceType.image.name));

    cloudinary.uploader().upload(srcTestImage,
        params:
            UploadParams(resourceType: ResourceType.raw.name, tags: setupTags));

    cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(
            tags: setupTags,
            transformation: Transformation().resize(Resize.scale().width(10))));
  });

  group('Uploader Tests', () {
    test('Test auto resource type', () async {
      var response = await cloudinary.uploader().upload(srcTestImage,
          params: UploadParams(
              colors: true,
              tags: defaultTags,
              resourceType: ResourceType.auto.name));
      assert(response?.data != null);
      var result = resultOrThrow(response?.data);
      assert(result.resourceType == 'image');
    });

    test('Test UTF8 upload success', () async {
      var response = await cloudinary.uploader().upload(srcTestImage,
          params:
              UploadParams(colors: true, tags: defaultTags, publicId: 'aåßéƒ'));
      assert(response?.data != null);
      var result = resultOrThrow(response?.data);
      assert(result.publicId != null);
      assert(result.width == srcTestImageW);
      assert(result.height == srcTestImageH);
      assert(result.colors != null);
      assert(result.predominant != null);

      validateSignature(result);

      response = await cloudinary.uploader().upload(srcTestImage,
          params:
              UploadParams(publicId: 'Plattenkreiss_ñg-é', tags: defaultTags));
      result = resultOrThrow(response?.data);
      assert(result.publicId == 'Plattenkreiss_ñg-é');
    });

    test('Test successfully urls parsing', () {
      var urls = [
        "ftp://ftp.cloudinary.com/images/old_logo.png",
        "http://cloudinary.com/images/old_logo.png",
        "https://cloudinary.com/images/old_logo.png",
        "s3://s3-us-west-2.amazonaws.com/cloudinary/images/old_logo.png",
        "gs://cloudinary/images/old_logo.png",
        "data:image/gif;charset=utf8;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7",
        "data:image/gif;param1=value1;param2=value2;base64," +
            "R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"
      ];
      for (String url in urls) {
        assert(Utils.isRemoteUrl(url));
      }

      var invalidUrls = ["adsadasdasdasd", "     ", ""];
      for (String invalidUrl in invalidUrls) {
        assert(Utils.isRemoteUrl(invalidUrl) == false);
      }
    });
  });

  test('Test upload Url successfully', () async {
    var response = await cloudinary.uploader().upload(remoteTestImageUrlString,
        params: UploadParams(colors: true, tags: defaultTags));
    var result = resultOrThrow(response?.data);
    assert(result.width == srcTestImageW);
  });

  test('Test upload data successfully', () async {
    var data =
        'data:image/png;base64,iVBORw0KGgoAA\nAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEUAAAD///+l2Z/dAAAAM0l\nEQVR4nGP4/5/h/1+G/58ZDrAz3D/McH8yw83NDDeNGe4Ug9C9zwz3gVLMDA/A6\nP9/AFGGFyjOXZtQAAAAAElFTkSuQmCC';
    var response = await cloudinary
        .uploader()
        .upload(data, params: UploadParams(tags: defaultTags));
    var result = resultOrThrow(response?.data);
    assert(result.width == 16);
    assert(result.height == 16);
    validateSignature(result);
  });

  test('Test unique filename param success', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(useFilename: true, tags: defaultTags));
    var result = resultOrThrow(response?.data);
    assert(result.publicId != null);
    assert(RegExp(r'old_logo_[a-z0-9]{6}').hasMatch(result.publicId!));

    response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(
            useFilename: true, uniqueFilename: false, tags: defaultTags));
    result = resultOrThrow(response?.data);
    assert(result.publicId == 'old_logo');
  });

  test('Test eager param success', () async {
    var transformation = Transformation().resize(Resize.scale()..width(2.0));
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(
            eager: [EagerTransformation.withFormat(transformation, Format.png)],
            tags: defaultTags));

    var eager = resultOrThrow(response?.data).eager?.first;
    assert(eager != null);
    assert(eager?.format == Format.png);
    assert(eager?.transformation == 'c_scale,w_2.0/png');
  });

  test('Test async parameter success', () async {
    var transformation = Transformation().resize(Resize.scale()..width(2.0));

    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(
            transformation: transformation, async: true, tags: defaultTags));
    var result = resultOrThrow(response?.data);

    assert(result.status == 'pending');
  });

  test('Test allowed formats parameter success', () async {
    var formats = ['png'];
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(allowedFormats: formats, tags: defaultTags));

    var result = resultOrThrow(response?.data);
    assert(result.format == 'png');
  });

  test('Test allowed formats with illegal format', () async {
    var formats = ['jpg'];

    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(allowedFormats: formats, tags: defaultTags));

    assert(response?.data == null);
    assert(response?.error != null);
  });

  test('Test allowed formats with correct format', () async {
    var formats = ['jpg'];

    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(
            allowedFormats: formats, tags: defaultTags, format: 'jpg'));

    var result = resultOrThrow(response?.data);
    assert(result.format == 'jpg');
  });

  test('Test face coordinates sucessfull', () async {
    var rect1 = Rectangle(121, 31, 110, 51);
    var rect2 = Rectangle(120, 30, 109, 51);

    var coordinates = Coordinates([rect1, rect2]);

    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(
            faceCoordinates: coordinates, faces: true, tags: defaultTags));
    var result = resultOrThrow(response?.data);
    var resultFaces = result.faces;
    assert(resultFaces?.coordinates.length == 2);
    assert(resultFaces?.coordinates[0] == rect1);
    assert(resultFaces?.coordinates[1] == rect2);
  });

  test('Test custom coordinates successful', () async {
    var coordinates = Coordinates.withString('121,31,300,151');

    var response = await cloudinary.uploader().upload(srcTestImage,
        params:
            UploadParams(customCoordinates: coordinates, tags: defaultTags));
    var result = resultOrThrow(response?.data);

    assert(Rectangle(121, 31, srcTestImageW, srcTestImageH) ==
        result.coordinates?.values.first.coordinates[0]);
  });

  test('Test moderation parameter successful', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(moderation: 'manual', tags: defaultTags));

    var result = resultOrThrow(response?.data);
    assert('manual' == result.moderation?.first.kind);
    assert('pending' == result.moderation?.first.status);
  });

  test('Test accessibility analysis resource parameter successful', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(accessibilityAnalysis: true, tags: defaultTags));

    var result = resultOrThrow(response?.data);
    assert(result.accessibilityAnalysis != null);
    assert(result.accessibilityAnalysis!.colorblindAccessibilityScore > 0);
    assert(result.accessibilityAnalysis!.colorblindAccessibilityAnalysis
            .distinctColors >
        0);
    assert(result.accessibilityAnalysis!.colorblindAccessibilityAnalysis
            .distinctEdges >
        0);
  });

  test('Test raw convert request success', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(rawConvert: 'illegal', tags: defaultTags));

    var error = response?.error;
    assert(error?.message == 'Raw convert is invalid');
  });

  test('Test raw categorization request success', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(categorization: 'illegal', tags: defaultTags));

    var error = response?.error;
    assert(error?.message == 'Categorization item illegal is not valid');
  });

  test('Test detection request success', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(detection: 'illegal', tags: defaultTags));

    var error = response?.error;
    assert(error?.message == "Detection invalid model 'illegal'");
  });

  test('Test Cloudinary upload with media metadata', () async {
    var response = await cloudinary
        .uploader()
        .upload(srcTestImage, params: UploadParams(mediaMetadata: true));

    var result = resultOrThrow(response?.data);
    assert(result.imageMetadata != null);
  });

  test('Test Cloudinary upload large', () async {
    File file = createTempFile();
    assert(6291456 == file.lengthSync());
    late UploadResult result;

    var uploadTags = ["upload_large_tag_$suffix", _sdkTestTag, _uploaderTag];
    cloudinary.config.apiConfig.chunkSize = 5 * 1024 * 1024;
    cloudinary.uploader().upload(file,
        params: UploadParams(
            resourceType: 'raw',
            useFilename: true,
            tags: uploadTags), completion: (response) {
      result = resultOrThrow(response.data);
    });
    await Future.delayed(Duration(seconds: 15));
    assert(listsAreEqual(result.tags, uploadTags));
    assert(result.resourceType == ResourceType.raw.name);
    assert(result.publicId?.startsWith('cldupload') ?? false);

    cloudinary.uploader().upload(file,
        params: UploadParams(
            filename: 'testFilename',
            resourceType: 'raw',
            useFilename: true,
            tags: uploadTags), completion: (response) {
      result = resultOrThrow(response.data);
    });
    await Future.delayed(Duration(seconds: 15));

    assert(result.originalFilename == 'testFilename');
    assert(result.publicId?.startsWith('testFilename') ?? false);
  }, timeout: Timeout(Duration(minutes: 3)));

  test('Test unsigned upload success', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(
            unsigned: true, uploadPreset: uploadPreset, tags: defaultTags));

    var result = resultOrThrow(response?.data);
    assert(result.width == srcTestImageW);
    assert(result.height == srcTestImageH);
  });

  test('Test filename option parameter success', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(filename: 'testFilename', tags: defaultTags));

    var result = resultOrThrow(response?.data);
    assert(result.originalFilename == 'testFilename');
  });

  test('Test responsive breakpoints success', () async {
    var breakpoint = ResponsiveBreakpoint(
        createDerived: true,
        maxImages: 2,
        format: "gif",
        transformation: Transformation().effect(Effect.sepia()));

    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(
            responsiveBreakpoints: [breakpoint], tags: defaultTags));

    var result = resultOrThrow(response?.data);
    assert(result.responsiveBreakpoints != null);

    assert(result.responsiveBreakpoints!.first.breakpoints.first.url
        .endsWith('gif'));
    assert(result.responsiveBreakpoints!.first.breakpoints.length == 2);
    assert(result.responsiveBreakpoints!.first.transformation == 'e_sepia');
  });

  test('Test access control parameter success', () async {
    DateTime start = DateTime.parse('2019-02-22 16:20:57 +0200');
    var token = AccessControlRule.token();
    var acl = AccessControlRule.anonymous(start, null);

    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(accessControl: [acl, token], tags: defaultTags));

    var result = resultOrThrow(response?.data);

    assert(result.accessControl != null);
    assert(result.accessControl!.length == 2);
    assert(result.accessControl![0].accessType == AccessType.anonymous);
    assert(result.accessControl![0].start == start);
    assert(result.accessControl![0].end == null);

    assert(result.accessControl![1].accessType == AccessType.token);
    assert(result.accessControl![1].start == null);
    assert(result.accessControl![1].end == null);
  });

  test('Test quality analysis success', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(qualityAnalysis: true, tags: defaultTags));

    var result = resultOrThrow(response?.data);
    assert(result.qualityAnalysis != null);
  });

  test('Test cinema graph analysis success', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(cinemagraphAnalysis: true, tags: defaultTags));

    var result = resultOrThrow(response?.data);
    assert(result.cinemagraphAnalysis != null);
  });

  test('Test filename overriden param success', () async {
    var response = await cloudinary.uploader().upload(srcTestImage,
        params:
            UploadParams(useFilename: true, filenameOverride: 'overridden'));

    var result = resultOrThrow(response?.data);
    assert(result.originalFilename == 'overridden');
  });

  test('Test rename api call success', () async {
    var response = await cloudinary
        .uploader()
        .upload(srcTestImage, params: UploadParams(tags: defaultTags));

    var result = resultOrThrow(response?.data);
    var publicId = result.publicId ?? '';
    var toPublicId = 'rename_${publicId}_$suffix';

    var renameResponse = await cloudinary.uploader().rename(
        params: RenameParams(
            fromPublicId: publicId,
            toPublicId: toPublicId,
            notificationUrl: 'www.test.com'));
    assert(toPublicId == renameResponse.data?.publicId);
  });

  test('Test explicit api call success', () async {
    var response = await cloudinary
        .uploader()
        .upload(srcTestImage, params: UploadParams(tags: defaultTags));

    var result = resultOrThrow(response?.data);
    var publicId = result.publicId ?? '';

    var transformation = Transformation()..resize(Resize.scale()..width(2.0));

    var explicitResponse = await cloudinary.uploader().explicit(ExplicitParams(
        publicId,
        params: UploadParams(
            eager: [EagerTransformation(transformation)],
            type: 'upload',
            moderation: 'manual')));

    var explicitResult = resultOrThrow(explicitResponse.data);

    var url = cloudinary
        .image(publicId)
        .extension(Format.png)
        .transformation(transformation)
        .version(explicitResult.version.toString())
        .toString();
    var eagerUrl = explicitResult.eager!.first.secureUrl;
    assert(url.substring(0, url.indexOf('?_a')) == eagerUrl);
  });

  test('Test destroy successful', () async {
    var response = await cloudinary
        .uploader()
        .upload(srcTestImage, params: UploadParams(tags: defaultTags));

    var result = resultOrThrow(response?.data);
    var publicId = result.publicId ?? '';

    var destroyResponse = await cloudinary.uploader().destroy(
        DestroyParams(publicId: publicId, notificationUrl: 'www.test.com'));
    assert(200 == destroyResponse.responseCode);
  });

  test('Test timeout exception', () async {
    cloudinary.config.apiConfig.chunkSize = 5 * 1024 * 1024;
    File file = createTempFile();
    late UploaderResponse result;
    await cloudinary.uploader().upload(file,
        params: UploadParams(resourceType: ResourceType.auto.name, timeout: 1),
        completion: (response) {
      result = response;
    });
    await Future.delayed(Duration(seconds: 5));
    assert(result.responseCode == -1);
    assert(result.error?.message == 'Timeout of 0:00:01.000000 occurred');
  });

  test('Test download backup successful', () async {
    var response = await cloudinary
        .uploader()
        .upload(srcTestImage, params: UploadParams(tags: defaultTags));
    final publicId = response?.data?.publicId;
    assert(publicId != null);

    // response = await cloudinary
    //     .uploader()
    //     .destroy(publicid);
    //
    // response cloudinary.api().restore(publicId);

    // final assetId = response?.data?.assetId;
    // final versionId = response?.data?.versionId;

    // response = cloudinary.uploader().downloadBackedupAsset(DownloadBackupParams(assetId, versionId));

    assert(response != null);
  }, skip: 'Skipping till restore is implemented as part of the admin API');

  test('Test add context successful', () async {
    String publicId = 'add_context_id' + suffix;
    var response = await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(
            publicId: publicId,
            context: {'caption': 'some caption', 'alt': 'alternative'}));
    UploadResult result = resultOrThrow<UploadResult>(response?.data);
    assert(result.publicId == publicId);

    ResultContext? context = result.context;
    assert(context != null);

    var addContextResponse = await cloudinary.uploader().addContext(
        AddContextParams(
            context: {'caption': 'new caption'}, publicIds: [publicId]));
    var addContextResult = resultOrThrow(addContextResponse.data);
    assert(addContextResult.publicIds != null);
    assert(addContextResult.publicIds!.contains(publicId));
  });

  test('Test remove all context successful', () async {
    String publicId = 'add_context_id' + suffix;
    await cloudinary.uploader().upload(srcTestImage,
        params: UploadParams(
            publicId: publicId,
            context: {'caption': 'some caption', 'alt': 'alternative'}));

    var response = await cloudinary
        .uploader()
        .removeAllContext(RemoveAllContextParams(publicIds: [publicId]));
    var result = resultOrThrow(response.data);

    assert(result.publicIds != null);
    assert(result.publicIds!.contains(publicId));
  });

  test('Test auto chaptering successful', () async {
    var response = await cloudinary.uploader().upload(srcTestVideo, params: UploadParams(resourceType: ResourceType.video.name, autoChaptering: true));
    var result = resultOrThrow(response?.data);
    assert(result.playbackUrl != null);
  });

  test('Test auto transcription successful', () async {
    var response = await cloudinary.uploader().upload(srcTestVideo, params: UploadParams(resourceType: ResourceType.video.name, autoTranscription: true));
    var result = resultOrThrow(response?.data);
    assert(result.playbackUrl != null);
  });

  test('Test signature with escaping characters', () {
    const cloudName = 'dn6ot3ged';
    const secret = 'hdcixPpR2iKERPwqvH6sHdK9cyac';

    final paramsWithAmpersand = {
      'cloud_name': cloudName,
      'timestamp': 1568810420,
      'notification_url': 'https://fake.com/callback?a=1&tags=hello,world'
    };

    final signatureWithAmpersand = Utils.apiSignRequest(paramsWithAmpersand, secret);

    final paramsSmuggled = {
      'cloud_name': cloudName,
      'timestamp': 1568810420,
      'notification_url': 'https://fake.com/callback?a=1',
      'tags': 'hello,world'
    };

    final signatureSmuggled = Utils.apiSignRequest(paramsSmuggled, secret);

    expect(signatureWithAmpersand, isNot(equals(signatureSmuggled)),
        reason: 'Signatures should be different to prevent parameter smuggling');

    const expectedSignature = '4fdf465dd89451cc1ed8ec5b3e314e8a51695704';
    expect(signatureWithAmpersand, equals(expectedSignature));

    const expectedSmuggledSignature = '7b4e3a539ff1fa6e6700c41b3a2ee77586a025f9';
    expect(signatureSmuggled, equals(expectedSmuggledSignature));

    final versionOneSignature = Utils.apiSignRequest(paramsSmuggled, secret, signatureVersion: 1);
    expect(versionOneSignature, equals(signatureSmuggled));
  });
}

validateSignature(UploadResult result) {
  Map<String, dynamic> toSign = <String, dynamic>{};
  toSign['public_id'] = result.publicId;
  toSign['version'] = result.version.toString();

  var expectedSignature =
      Utils.apiSignRequest(toSign, cloudinary.config.cloudConfig.apiSecret!);
  assert(result.signature == expectedSignature);
}

T resultOrThrow<T extends BaseUploadResult>(T? result) {
  if (result == null) {
    throw ArgumentError('Result is null, something went wrong');
  }
  return result;
}
