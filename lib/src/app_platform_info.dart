part of app_device;

// ==========================================
// CLASS: AppPlatformInfo
// ==========================================

class AppPlatformInfo extends AppInfoBase {
  AppPlatformInfo._(this.device) {
    // Per BaseDeviceInfo documentation:
    // "Warning: The returned Map may not be JSON-encodable"
    deviceJson = device.data.map((key, value) {
      return MapEntry(
        key,
        jsonDecode(jsonEncode(value, toEncodable: (value) => value.toString())),
      );
    });
  }

  /// Object encapsulating the device information
  final BaseDeviceInfo device;

  /// JSON-encodable version of [BaseDeviceInfo] - valid for all device types
  ///
  /// Although [BaseDeviceInfo] is not guaranteed to be JSON-encodable per documentation, this version protects the json encoding ands defaults to string representation if not encodable
  late final Map<String, dynamic> deviceJson;

  /// Indicates application was compiled to run on the web
  final bool isWeb = kIsWeb;

  /// Indicates application was compiled to run on Android
  final bool isAndroid = kIsWeb ? false : Platform.isAndroid;

  /// Indicates application was compiled to run on iOS
  final bool isIOS = kIsWeb ? false : Platform.isIOS;

  /// Indicates application was compiled to run on MacOS
  final bool isMacOS = kIsWeb ? false : Platform.isMacOS;

  /// Indicates application was compiled to run on Linux
  final bool isLinux = kIsWeb ? false : Platform.isLinux;

  /// Indicates application was compiled to run on Windows
  final bool isWindows = kIsWeb ? false : Platform.isWindows;

  /// Indicates application was compiled to run on Fuchsia
  final bool isFuchsia = kIsWeb ? false : Platform.isFuchsia;

  /// Indicates application was compiled to run on a desktop platform
  final bool isDesktop = AppInfo.isDesktopPlatform;

  /// Indicates application was compiled to run on a mobile platform
  final bool isMobile = AppInfo.isMobilePlatform;

  /// The environment for this process as a map from string key to string value
  ///
  /// See [Platform.environment]
  final Map<String, String> environment = kIsWeb ? {} : Platform.environment;

  /// The environment for this process as a map from string key to string value.
  ///
  /// See [Platform.executable]
  final String executable = kIsWeb ? '' : Platform.executable;

  /// These are the command-line flags to the executable that precedes the script name. Provides a new list every time the value is read
  ///
  /// See [Platform.executableArguments]
  final List<String> executableArguments =
      kIsWeb ? [] : Platform.executableArguments;

  /// The local hostname for the system
  ///
  /// See [Platform.localHostname]
  final String localHostname = kIsWeb ? '' : Platform.localHostname;

  /// Get the name of the current locale
  ///
  /// See [Platform.localeName]
  final String localeName = kIsWeb ? '' : Platform.localeName;

  /// The number of individual execution units of the machine
  ///
  /// See [Platform.numberOfProcessors]
  final int numberOfProcessors = kIsWeb ? 0 : Platform.numberOfProcessors;

  /// A string representing the version of the operating system or platform.
  ///
  /// See [Platform.operatingSystem]
  final String operatingSystem = kIsWeb ? '' : Platform.operatingSystem;

  /// A string representing the version of the operating system or platform
  ///
  /// See [Platform.operatingSystemVersion]
  final String operatingSystemVersion =
      kIsWeb ? '' : Platform.operatingSystemVersion;

  /// The --packages flag passed to the executable used to run the script in this isolate
  ///
  /// See [Platform.packageConfig]
  final String packageConfig = kIsWeb ? '' : Platform.packageConfig ?? '';

  /// The path separator used by the operating system to separate components in file paths
  ///
  /// See [Platform.pathSeparator]
  final String pathSeparator = kIsWeb ? '' : Platform.pathSeparator;

  /// The path of the executable used to run the script in this isolate after it has been resolved by the OS
  ///
  /// See [Platform.resolvedExecutable]
  final String resolvedExecutable = kIsWeb ? '' : Platform.resolvedExecutable;

  /// The absolute URI of the script being run in this isolate
  ///
  /// See [Platform.script]
  final Uri script = kIsWeb ? Uri() : Platform.script;

  /// The version of the current Dart runtime.
  ///
  /// See [Platform.version]
  final String version = kIsWeb ? '' : Platform.version;

  // ------------------------------------------
  // METHOD: get
  // ------------------------------------------

  static Future<AppPlatformInfo> get() async {
    return AppPlatformInfo._(await DeviceInfoPlugin().deviceInfo);
  }

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

  // ------------------------------------------
  // METHOD: toString
  // ------------------------------------------

  @override
  String toString() {
    return 'AppPlatformInfo(${toJson()})';
  }
}
