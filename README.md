# flutter_app_info

[![Pub](https://img.shields.io/pub/v/flutter_app_info.svg)](https://pub.dev/packages/flutter_app_info)

[`flutter_app_info`](https://pub.dev/packages/flutter_app_info) is a utility package that bundles capability of the following popular packages (so you do not need to directly depend on them) into a **single**, easy to access, `AppInfo` inherited widget:

* [`device_info_plus`](https://pub.dev/packages/device_info_plus)
* [`package_info_plus`](https://pub.dev/packages/package_info_plus)
* [`version`](https://pub.dev/packages/version)

## Is this package actively maintained?

Yes! This package is used in production applications and is actively maintained!

## Why use this package?

Support for **all platforms**.

Do you find yourself constantly writing the same device/package/version utility code every time you spin up a new project? If so, this might be a helpful package for you! This package will automatically fetch the `async` information from `device_info_plus` and `package_info_plus` at the launch of your app and make that available for every widget within your tree - in two lines of code.

Along with making all of the properties from these to packages easily accessible in a consistent manner, the data is structured so that it is logical and easy to traverse. Further, there are certain restrictions to accessing platform related information on web and this package automatically protects for those cases and avoids unexpected errors.

## Quick setup

Instead of the standard application `main()` function:

```dart
void main() {
  runApp(const MyApp());
}
```

Simply update the `main()` as seen below to wrap the root of your app. That's it! Now, the `AppInfoData` structure is available everywhere within your app without needing to call any of the `async` constructors multiple times should you need the data in multiple places.

```dart
import 'package:flutter_app_info/flutter_app_info.dart';

void main() async {
  runApp(
    AppInfo(
      data: await AppInfoData.get(),
      child: const MyApp(),
    ),
  );
}
```

Now, anywhere within your app you can access the `AppInfo` class to retrieve the `AppInfoData`:

```dart
final info = AppInfo.of(context);
```

* `info.package`
  * Information about the installed package and version
* `info.platform`
  * Information about the platform for which the app was built
  * For example, if the app was built for web this will report browser device information
* `info.target`
  * Information about the platform on which the app is currently executing
  * For example, if the app was built for web, but running on a Mac, that will be denoted

Helpful properties are found within these data structures that expand on the existing information from `device_info_plus`, `package_info_plus`, `io.Platform`, and `io.TargetPlatform`. There are also protections to ensure that the platform data can be called on all device types, including web. See all of the examples below.

## Retrieve package and version information

All package related information can be found under the following structure:

```dart
final package = AppInfo.of(context).package;

print(package.appName);
print(package.buildSignature);
print(package.installerStore);
```

The version information returns a [Version](https://pub.dev/documentation/version/latest/version/Version-class.html) object which is useful for comparison purposes as well as parsing in accordance with the Semantic Versioning [specification](https://semver.org/).

```dart
print(package.version); // 1.0.0+1
print(package.version.major); // 1
print(package.version.minor); // 0
print(package.version.patch); // 0
print(package.version.build); // 1
print(package.versionWithoutBuild); // 1.0.0
print(package.version == package.versionWithoutBuild); // true
print(package.version < Version(1, 1, 1)); // true
print(package.version > Version(1, 1, 1)); // false
```

## Retrieve build platform and device information

All platform related information can be found under the following structure. Using `AppInfo` to access platform information **ensures that you get a safe, cross platform, way to access** these properties without having to worry about any platform errors when using [Platform](https://api.flutter.dev/flutter/dart-io/Platform-class.html) directly (e.g. when deployed to web).

```dart
final platform = AppInfo.of(context).platform;

print(platform.isAndroid);
print(platform.isIOS);
print(platform.isMacOS);
print(platform.isLinux);
print(platform.isWeb);
print(platform.isWindows);
print(platform.isFuchsia);
print(platform.isDesktop);
print(platform.isMobile);
print(platform.environment);
print(platform.executable);
print(platform.executableArguments);
print(platform.localHostname);
print(platform.localeName);
print(platform.numberOfProcessors);
print(platform.operatingSystem);
print(platform.operatingSystemVersion);
print(platform.packageConfig);
print(platform.pathSeparator);
print(platform.resolvedExecutable);
print(platform.script);
print(platform.version);
```

This structure also contains the device information for the device that the app was built for. For example, on a Mac app you can access the machine information under:

```dart
platform.device
```

The `device` property returns [BaseDeviceInfo](https://pub.dev/documentation/device_info_plus_platform_interface/latest/model_base_device_info/BaseDeviceInfo-class.html) so that the return type is consistent. If desired, at any point you may cast this property to the appropriate type if the proper checks are made:

```dart
/// Import to access device_info_plus package classes (e.g. MacOsDeviceInfo)
import 'package:flutter_app_info/device_info_plus.dart';

if (platform.isMacOS) {
  final device = platform.device as MacOsDeviceInfo;
}
```

All of the `device_info_plus` specific types are linked below for quick reference:

* [`AndroidDeviceInfo`](https://pub.dev/documentation/device_info_plus/latest/device_info_plus/AndroidDeviceInfo-class.html)
* [`IosDeviceInfo`](https://pub.dev/documentation/device_info_plus/latest/device_info_plus/IosDeviceInfo-class.html)
* [`LinuxDeviceInfo`](https://pub.dev/documentation/device_info_plus/latest/device_info_plus/LinuxDeviceInfo-class.html)
* [`MacOsDeviceInfo`](https://pub.dev/documentation/device_info_plus/latest/device_info_plus/MacOsDeviceInfo-class.html)
* [`WebBrowserInfo`](https://pub.dev/documentation/device_info_plus/latest/device_info_plus/WebBrowserInfo-class.html)
* [`WindowsDeviceInfo`](https://pub.dev/documentation/device_info_plus/latest/device_info_plus/WindowsDeviceInfo-class.html)

Although `BaseDeviceInfo` is not guaranteed Json-encodable (per `device_info_plus` documentation), `AppInfo` provides a safe encodable version:

```dart
platform.deviceJson
```

The platform information (which includes the `deviceJson` data) can be safely exported to JSON via:

```dart
platform.toJson()
```

## Retrieve target platform information

All platform target related information can be found under the following structure:

```dart
final target = AppInfo.of(context).target;

print(target.defaultPlatform);
print(target.isAndroid);
print(target.isIOS);
print(target.isMacOS);
print(target.isLinux);
print(target.isWeb);
print(target.isWindows);
print(target.isFuchsia);
print(target.isDesktop);
print(target.isDesktopWeb);
print(target.isMobile);
print(target.isMobileWeb);
print(target.isTablet);
```

The target information can be safely exported to JSON via:

```dart
target.toJson()
```

## Static properties

There are few static properties that may be useful for use without access to the inherited `AppInfo` widget (for example at the start of the app before anything else runs):

* `AppInfo.isWeb`
  * Denotes app was built for web
* `AppInfo.isDesktopPlatform`
  * Denotes app was built for a desktop platform
* `AppInfo.isMobilePlatform`
  * Denotes app was built for a mobile platform
* `AppInfo.isDesktopTarget`
  * Denotes app is running on a desktop target
* `AppInfo.isDesktopWebTarget`
  * Denotes app was built for web and is running on a desktop browser
* `AppInfo.isMobileTarget`
  * Denotes app is running on a mobile target
* `AppInfo.isMobileWebTarget`
  * Denotes app was built for web and is running on a mobile browser

## Directly import dependency libraries (if needed)

This should **not** be required for most use cases, but should you need access to the entire `device_info_plus` or `package_info_plus` libraries that are used by `flutter_app_info`, you may import those individually, as needed:

```dart
import 'package:flutter_app_info/package_info_plus.dart';
import 'package:flutter_app_info/device_info_plus.dart';
```

## Contributing

Please see the [`flutter_app_info`](https://github.com/tazatechnology/flutter_app_info)  Github repository.
