## 2.0.0

### Breaking Changes

- **Package structure migrated to follow Dart conventions**
  - All public APIs now exported through main `lib/cloudinary_api.dart` file
  - Internal implementation moved to `lib/src/` (private by convention)
  - Models consolidated in `lib/src/models/` directory
  - Uploader implementation consolidated in `lib/src/uploader/`

### Migration Guide

**Before:**

```dart
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:cloudinary_api/src/response/upload_result.dart';
```

**After:**

```dart
import 'package:cloudinary_api/cloudinary_api.dart';
// All public APIs are now available through the main import
```

### What Changed

- `lib/uploader/` → consolidated into `lib/src/uploader/`
- `lib/src/request/model/` → moved to `lib/src/models/`
- `lib/src/response/` → moved to `lib/src/models/`
- All models and public classes now properly exported through main library file
- Internal APIs remain accessible but use `lib/src/` imports explicitly

### Benefits

- Cleaner public API surface
- Better IDE autocomplete and documentation
- Follows official Dart package conventions
- Clearer separation between public and internal APIs

## 1.1.1

- Fix API parameters signature

## 1.1.0
- Add `notification_url` to rename params
- Add `destroy` api
- Add `download_backup` api
- Add metadata management context
- Add `auto_chaptering` and `auto_transcription`

## 1.0.2
- Update url_gen package

## 1.0.1
- Update http package

## 1.0.0
- General Access

## 0.9.0
- Implement Upload API