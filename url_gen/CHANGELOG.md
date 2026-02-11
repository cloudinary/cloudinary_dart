## 2.0.0

### Breaking Changes

- **Package structure migrated to follow Dart conventions**
  - All public APIs now exported through main `lib/cloudinary.dart` file
  - Internal implementation moved to `lib/src/` (private by convention)
  - Transformation classes moved to `lib/src/transformation/`
  - Configuration classes moved to `lib/src/config/`
  - Analytics moved to `lib/src/analytics/`
  - Asset classes moved to `lib/src/asset/`

### Migration Guide

**Before:**

```dart
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
import 'package:cloudinary_url_gen/config/cloudinary_config.dart';
```

**After:**

```dart
import 'package:cloudinary_url_gen/cloudinary.dart';
// All public APIs are now available through the main import
```

### What Changed

- `lib/transformation/` → moved to `lib/src/transformation/`
- `lib/config/` → moved to `lib/src/config/`
- `lib/analytics/` → moved to `lib/src/analytics/`
- `lib/asset/` → moved to `lib/src/asset/`
- All transformation, configuration, and asset classes now properly exported through main library file
- `lib/auth_token.dart` remains as a specialized export (common Dart pattern)

### Benefits

- Cleaner public API surface
- Better IDE autocomplete and documentation
- Follows official Dart package conventions
- Clearer separation between public and internal APIs
- Single import for most use cases

## 1.8.0

- Add signature version
- Fix parsing field "bytes" in UploadResult

## 1.7.0
- Format fixing

## 1.6.0
- Add generative backgrond replace 
- Add auto pad 
- Add crop auto 
- Add blur faces and blur region 
- Add upscale 
- Add enahnce 
- Add `media_metadata` support

## 1.5.0
- Update analytics token

## 1.4.4
- Secure `Platform` usage

## 1.4.3
- Fix analytics token os version function

## 1.4.2
- Fix analytics os version

## 1.4.1
- Fix algo version
- Remove not needed imports

## 1.4.0
- Fix signature api key
- Fix analytics token OS
- Add Reshape action
- Add Colorspace
- Add default image action
- Add density action
- Update generative replace
- Update generative Recolor

## 1.3.0
- Add progress bar effect
- Add video codec action
- Add zoom pan action
- Add generative recolor effect
- Add generative remove effect
- Add generative replace effect
- Add generative restore effect
- Fix gravity values

## 1.2.0
- Update analytics token

## 1.1.0
- Update analytics token

## 1.0.0
- General Access

## 0.10.0
- Fix version to accept int and String
- Add VideoEdit actions
- Fix analytics token

## 0.9.0
- Change to url_gen package

## 0.0.11
- Add `DropShadow` action

## 0.0.10 
- Fix `Quality` action 
- Add signature support 
- Add Code-Snippets support

## 0.0.9
- Add `Border` action support
- Add `Extract` action support
- Add named transformation action support

## 0.0.8
- Fix `FocusOn` syntax
- Fix `AutoGravity` syntax

## 0.0.7
- Add Cloudinary initialisation option
- Update Cloudinary syntax

## 0.0.6
- Refactor class names

## 0.0.5
- Add `Rotate` action
- Add `Adjust` action

## 0.0.4
- Add Transformation Builder
- Add `Delivery`, `Effect` and `Resize` actions support.

## 0.0.3
- Update file tree

## 0.0.2
- Fix files formatting

## 0.0.1
- Alpha version.
