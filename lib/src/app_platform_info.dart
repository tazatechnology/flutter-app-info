part of 'index.dart';

// ==========================================
// CLASS: AppPlatformInfo
// ==========================================

/// Object encapsulating information about the platform for which the app was built.
class AppPlatformInfo extends AppInfoBase {
  AppPlatformInfo._({required BaseDeviceInfo data}) {
    device = data;
    // Per BaseDeviceInfo documentation:
    // "Warning: The returned Map may not be JSON-encodable"
    deviceJson = device.data.map((key, value) {
      return MapEntry(
        key,
        jsonDecode(jsonEncode(value, toEncodable: (value) => value.toString())),
      );
    });
  }

  /// Object encapsulating the device information. Depending on the current platform, this property can be downcast to [AndroidDeviceInfo], [IosDeviceInfo], [LinuxDeviceInfo], [MacOsDeviceInfo], [WebBrowserInfo], or [WindowsDeviceInfo],
  late final BaseDeviceInfo device;

  /// JSON-encodable version of [BaseDeviceInfo.data] - valid for all device types. Although [BaseDeviceInfo.data] is not guaranteed to be JSON-encodable per documentation, this version protects the json encoding ands defaults to string representation if not encodable
  late final Map<String, dynamic> deviceJson;

  /// Indicates application was compiled to run on the web
  final bool isWeb = kIsWeb;

  /// Indicates application was compiled to run on Android (see [Platform.isAndroid])
  final bool isAndroid = kIsWeb ? false : Platform.isAndroid;

  /// Indicates application was compiled to run on iOS (see [Platform.isIOS])
  final bool isIOS = kIsWeb ? false : Platform.isIOS;

  /// Indicates application was compiled to run on MacOS (see [Platform.isMacOS])
  final bool isMacOS = kIsWeb ? false : Platform.isMacOS;

  /// Indicates application was compiled to run on Linux (see [Platform.isLinux])
  final bool isLinux = kIsWeb ? false : Platform.isLinux;

  /// Indicates application was compiled to run on Windows (see [Platform.isWindows])
  final bool isWindows = kIsWeb ? false : Platform.isWindows;

  /// Indicates application was compiled to run on Fuchsia (see [Platform.isFuchsia])
  final bool isFuchsia = kIsWeb ? false : Platform.isFuchsia;

  /// Indicates application was compiled to run on a desktop platform
  final bool isDesktop = AppInfo.isDesktopPlatform;

  /// Indicates application was compiled to run on a mobile platform
  final bool isMobile = AppInfo.isMobilePlatform;

  /// The environment for this process as a map from string key to string value (see [Platform.environment])
  final Map<String, String> environment = kIsWeb ? {} : Platform.environment;

  /// The environment for this process as a map from string key to string value (see [Platform.executable])
  final String executable = kIsWeb ? '' : Platform.executable;

  /// These are the command-line flags to the executable that precedes the script name. Provides a new list every time the value is read (see [Platform.executableArguments])
  final List<String> executableArguments =
      kIsWeb ? [] : Platform.executableArguments;

  /// The local hostname for the system (see [Platform.localHostname])
  final String localHostname = kIsWeb ? '' : Platform.localHostname;

  /// Get the name of the current locale (see [Platform.localeName])
  final String localeName = kIsWeb ? '' : Platform.localeName;

  /// The number of individual execution units of the machine (see [Platform.numberOfProcessors])
  final int numberOfProcessors = kIsWeb ? 0 : Platform.numberOfProcessors;

  /// A string representing the version of the operating system or platform (see [Platform.operatingSystem])
  final String operatingSystem = kIsWeb ? '' : Platform.operatingSystem;

  /// A string representing the version of the operating system or platform (see [Platform.operatingSystemVersion])
  final String operatingSystemVersion =
      kIsWeb ? '' : Platform.operatingSystemVersion;

  /// The --packages flag passed to the executable used to run the script in this isolate (see [Platform.packageConfig])
  final String packageConfig = kIsWeb ? '' : Platform.packageConfig ?? '';

  /// The path separator used by the operating system to separate components in file paths (see [Platform.pathSeparator])
  final String pathSeparator = kIsWeb ? '' : Platform.pathSeparator;

  /// The path of the executable used to run the script in this isolate after it has been resolved by the OS (see [Platform.resolvedExecutable])
  final String resolvedExecutable = kIsWeb ? '' : Platform.resolvedExecutable;

  /// The absolute URI of the script being run in this isolate (see [Platform.script])
  final Uri script = kIsWeb ? Uri() : Platform.script;

  /// The version of the current Dart runtime. (see [Platform.version])
  final String version = kIsWeb ? '' : Platform.version;

  // ------------------------------------------
  // METHOD: toJson
  // ------------------------------------------

  /// Represent results as JSON map
  @override
  Map<String, Object> toJson() {
    return {
      'isWeb': isWeb,
      'isAndroid': isAndroid,
      'isIOS': isIOS,
      'isMacOS': isMacOS,
      'isLinux': isLinux,
      'isWindows': isWindows,
      'isFuchsia': isFuchsia,
      'isDesktop': isDesktop,
      'isMobile': isMobile,
      'executable': executable,
      'executableArguments': executableArguments,
      'localHostname': localHostname,
      'localeName': localeName,
      'numberOfProcessors': numberOfProcessors,
      'operatingSystem': operatingSystem,
      'operatingSystemVersion': operatingSystemVersion,
      'packageConfig': packageConfig,
      'pathSeparator': pathSeparator,
      'resolvedExecutable': resolvedExecutable,
      'script': script.toString(),
      'version': version,
      'device': deviceJson,
    };
  }
}
