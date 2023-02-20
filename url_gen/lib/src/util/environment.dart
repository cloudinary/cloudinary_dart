import 'dart:io';

const String cloudinaryUrl = "CLOUDINARY_URL";

class Environment {
  static String? cloudinaryUrlFromEnv() {
    Map<String, String> env = Platform.environment;
    return env[cloudinaryUrl];
  }
}
