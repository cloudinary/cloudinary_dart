Cloudinary Kotlin SDK
=========================
[![Build Status](https://api.travis-ci.com/cloudinary/cloudinary_dart.svg?branch=master)](https://app.travis-ci.com/github/cloudinary/cloudinary_dart)
## About
The Cloudinary Dart SDK allows you to quickly and easily integrate your application with Cloudinary.
Effortlessly optimize and transform your cloud's assets.

### Additional documentation
This Readme provides basic installation and usage information.
For the complete documentation, see the [Dart SDK Guide](https://cloudinary.com/documentation/kotlin_integration).

## Table of Contents
- [Key Features](#key-features)
- [Version Support](#Version-Support)
- [Installation](#installation)
  - [Import](#import)
- [Usage](#usage)
    - [Setup](#Setup)
    - [Transform and Optimize Assets](#Transform-and-Optimize-Assets)

## Key Features
- [Transform](https://cloudinary.com/documentation/kotlin_media_transformations) and [optimize](https://cloudinary.com/documentation/kotlin_media_transformations#image_optimizations) assets.

## Version Support
| SDK Version | Dart Version |
|-------------|--------------|
| 0.0.1       | > 1.0        | 

## Installation
To use this SDK, add cloudinary as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

**Using Pub**
```yaml
dependencies:
  cloudinary: ^0.0.1
```
### Import
```dart
import 'package:cloudinary/cloudinary.dart';
```

## Usage
### Setup
The `Cloudinary` class is the main entry point for using the library. Your `cloud_name` is required to create an instance of this class. Your `api_key` and `api_secret` are also needed to perform secure API calls to Cloudinary (e.g., image and video uploads). Setting the configuration parameters can be done either programmatically using an appropriate constructor of the Cloudinary class or globally using an environment variable. You can find your account-specific configuration parameters in the **Dashboard** page of your [account console](https://cloudinary.com/console).

Here's an example of setting configuration parameters in your Dart application:

```dart

```
