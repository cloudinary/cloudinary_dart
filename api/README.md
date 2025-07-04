Cloudinary Dart SDK
=========================
[![Build Status](https://api.travis-ci.com/cloudinary/cloudinary_dart.svg?branch=master)](https://app.travis-ci.com/github/cloudinary/cloudinary_dart)
## About
The Cloudinary API Dart SDK allows you to quickly and easily integrate your application with Cloudinary.
Effortlessly upload your assets to your cloud.

As Flutter is build on the Dart language, understanding the Dart SDK is essential for utilizing the capabilities of the Flutter SDK, as well. For more information about the Flutter SDK, see the [Cloudinary Flutter documentation](https://cloudinary.com/documentation/flutter_integration).


### Note
This Readme provides basic installation and usage information.

## Table of Contents
- [Key Features](#key-features)
- [Version Support](#Version-Support)
- [Installation](#installation)
- [Usage](#usage)
  - [Setup](#Setup)
  - [Upload](#Upload)

## Key Features
Transform and optimize assets. Visit our documentation to learn more about [media optimization](https://cloudinary.com/documentation/media_optimization) and [transformations](https://cloudinary.com/documentation/image_transformations).

## Version Support
| SDK Version | Dart Version |
|-------------|--------------|
| 1.x         | > 1.0        | 

## Installation
To use this SDK, add cloudinary as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

```yaml
dependencies:
  cloudinary_api: ^1.1.1
  cloudinary_url_gen: ^1.8.0
```

## Usage
### Setup
The `Cloudinary` class is the main entry point for using the library. Your `cloud_name` is required to create an instance of this class. Your `api_key` and `api_secret` are also needed to perform secure API calls to Cloudinary (e.g., image and video uploads). Setting the configuration parameters can be done either programmatically using an appropriate constructor of the Cloudinary class or globally using an environment variable. You can find your account-specific configuration parameters in the **Dashboard** page of your [account console](https://cloudinary.com/console).

Here's an example of setting configuration parameters in your Dart application:

```dart
import 'package:cloudinary_url_gen/cloudinary.dart';

var cloudinary = Cloudinary.fromStringUrl('cloudinary://<your-api-key>:<your-api-secret>@<your-cloud-name>');
```

### Upload
To upload a file you need to call you `cloudinary` object with `uploader()`, here's an example:

```dart
var response = cloudinary.uploader().upload(file);
```


## Contributions
See [contributing guidelines](CONTRIBUTING.md).

## Get Help
If you run into an issue or have a question, you can either:
- [Open a GitHub issue](https://github.com/cloudinary/cloudinary_kotlin/issues) (for issues related to the SDK)
- [Open a support ticket](https://cloudinary.com/contact) (for issues related to your account)

## About Cloudinary
Cloudinary is a powerful media API for websites and mobile apps alike, Cloudinary enables developers to efficiently manage, transform, optimize, and deliver images and videos through multiple CDNs. Ultimately, viewers enjoy responsive and personalized visual-media experiences—irrespective of the viewing device.

## Additional Resources
- [Cloudinary Transformation and REST API References](https://cloudinary.com/documentation/cloudinary_references): Comprehensive references, including syntax and examples for all SDKs.
- [MediaJams.dev](https://mediajams.dev/): Bite-size use-case tutorials written by and for Cloudinary Developers.
- [DevJams](https://www.youtube.com/playlist?list=PL8dVGjLA2oMr09amgERARsZyrOz_sPvqw): Cloudinary developer podcasts on YouTube.
- [Cloudinary Academy](https://training.cloudinary.com/): Free self-paced courses, instructor-led virtual courses, and on-site courses.
- [Code Explorers and Feature Demos](https://cloudinary.com/documentation/code_explorers_demos_index): A one-stop shop for all code explorers, Postman collections, and feature demos found in the docs.
- [Cloudinary Roadmap](https://cloudinary.com/roadmap): Your chance to follow, vote, or suggest what Cloudinary should develop next.
- [Cloudinary Facebook Community](https://www.facebook.com/groups/CloudinaryCommunity): Learn from and offer help to other Cloudinary developers.
- [Cloudinary Account Registration](https://cloudinary.com/users/register/free): Free Cloudinary account registration.
- [Cloudinary Website](https://cloudinary.com): Learn about Cloudinary's products, partners, customers, pricing, and more.

## Licence
Released under the MIT license.