part of app_device;

// ==========================================
// CLASS: AppPlatformInfo
// ==========================================

class AppPlatformInfo extends AppInfoBase {
  AppPlatformInfo._(this.device);

  final BaseDeviceInfo device;
  final bool isWeb = kIsWeb;
  final bool isAndroid = kIsWeb ? false : Platform.isAndroid;
  final bool isIOS = kIsWeb ? false : Platform.isIOS;
  final bool isMacOS = kIsWeb ? false : Platform.isMacOS;
  final bool isLinux = kIsWeb ? false : Platform.isLinux;
  final bool isWindows = kIsWeb ? false : Platform.isWindows;
  final bool isFuchsia = kIsWeb ? false : Platform.isFuchsia;
  final bool isDesktop = AppInfo.isDesktopPlatform;
  final bool isMobile = AppInfo.isMobilePlatform;
  final Map<String, String> environment = kIsWeb ? {} : Platform.environment;
  final String executable = kIsWeb ? '' : Platform.executable;
  final List<String> executableArguments = kIsWeb ? [] : Platform.executableArguments;
  final String localHostname = kIsWeb ? '' : Platform.localHostname;
  final String localeName = kIsWeb ? '' : Platform.localeName;
  final int numberOfProcessors = kIsWeb ? 0 : Platform.numberOfProcessors;
  final String operatingSystem = kIsWeb ? '' : Platform.operatingSystem;
  final String operatingSystemVersion = kIsWeb ? '' : Platform.operatingSystemVersion;
  final String packageConfig = kIsWeb ? '' : Platform.packageConfig ?? '';
  final String pathSeparator = kIsWeb ? '' : Platform.pathSeparator;
  final String resolvedExecutable = kIsWeb ? '' : Platform.resolvedExecutable;
  final Uri script = kIsWeb ? Uri() : Platform.script;
  final String version = kIsWeb ? '' : Platform.version;

  // ------------------------------------------
  // METHOD: fetch
  // ------------------------------------------

  static Future<AppPlatformInfo> get() async {
    return AppPlatformInfo._(await DeviceInfoPlugin().deviceInfo);
  }

  // ------------------------------------------
  // METHOD: toJson
  // ------------------------------------------

  // Represent results as JSON map
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
      'device': device.data.map((key, value) {
        // Per BaseDeviceInfo documentation:
        // "Warning: The returned Map may not be JSON-encodable"
        // Protect the json encoding, default to string representation if not encodable
        return MapEntry(key, jsonDecode(jsonEncode(value, toEncodable: (value) => value.toString())));
      }),
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
