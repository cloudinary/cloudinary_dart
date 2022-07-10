import 'dart:io';

class Environment {
  static String? cloudinaryUrlFromEnv() {
    Map<String, String> env = Platform.environment;
    return env["CLOUDINARY_URL"];
  }
}
