/// Cloudinary API Library
///
/// A Dart SDK for uploading and managing media assets with Cloudinary.
library cloudinary_api;

// Uploader
export 'src/uploader/cloudinary_uploader.dart';
export 'src/uploader/uploader.dart';
export 'src/uploader/uploader_response.dart';

// Models - Requests
export 'src/models/upload_request.dart';
export 'src/models/uploader_request.dart';
export 'src/models/payload.dart';

// Models - Responses
export 'src/models/upload_result.dart';
export 'src/models/upload_error.dart';

// Models - Params
export 'src/models/uploader_params.dart';
export 'src/models/params/access_control_rule.dart';
export 'src/models/params/coordinates.dart';
export 'src/models/params/eager_transformation.dart';
export 'src/models/params/resource_type.dart';
export 'src/models/params/responsive_breakpoint.dart';

// Abstract interfaces
export 'src/uploader/abstract_uploader_request.dart';

// Utilities
export 'src/uploader/utils.dart';

// HTTP types (for callbacks)
export 'src/http/request/multi_part_request.dart'
    show ProgressCallback, CompletionCallback;
