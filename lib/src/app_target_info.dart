part of app_device;

// ==========================================
// CLASS: AppTargetInfo
// ==========================================

/// Object encapsulating information about the platform on which the app is currently executing.
class AppTargetInfo extends AppInfoBase {
  AppTargetInfo._({required MediaQueryData data}) {
    isTablet = AppInfo.isMobileTarget && data.size.shortestSide >= 550;
  }

  /// The [TargetPlatform] that matches the platform on which the framework is currently executing
  final TargetPlatform defaultPlatform = defaultTargetPlatform;

  /// Indicates application was compiled to run on the web
  final bool isWeb = kIsWeb;

  /// Indicates application is running on Android
  final bool isAndroid = defaultTargetPlatform == TargetPlatform.android;

  ///Indicates application is running on iOS
  final bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;

  /// Indicates application is running on MacOS
  final bool isMacOS = defaultTargetPlatform == TargetPlatform.macOS;

  /// Indicates application is running on Linux
  final bool isLinux = defaultTargetPlatform == TargetPlatform.linux;

  /// Indicates application is running on Windows
  final bool isWindows = defaultTargetPlatform == TargetPlatform.windows;

  /// Indicates application is running on Fuchsia
  final bool isFuchsia = defaultTargetPlatform == TargetPlatform.fuchsia;

  /// Indicates application is running on a desktop device
  final bool isDesktop = AppInfo.isDesktopTarget;

  /// Indicates application is running on a desktop browser
  final bool isDesktopWeb = AppInfo.isDesktopWebTarget;

  /// Indicates application is running on a mobile device
  final bool isMobile = AppInfo.isMobileTarget;

  /// Indicates application is running on a mobile browser
  final bool isMobileWeb = AppInfo.isMobileWebTarget;

  /// Indicates application is running on a tablet device
  late final bool isTablet;

  // ------------------------------------------
  // METHOD: get
  // ------------------------------------------

  static Future<AppTargetInfo> get() async {
    return AppTargetInfo._(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
    );
  }

  // ------------------------------------------
  // METHOD: toJson
  // ------------------------------------------

  // Represent results as JSON map
  @override
  Map<String, Object> toJson() {
    return {
      'defaultPlatform': defaultPlatform.name,
      'isWeb': isWeb,
      'isAndroid': isAndroid,
      'isIOS': isIOS,
      'isMacOS': isMacOS,
      'isLinux': isLinux,
      'isWindows': isWindows,
      'isFuchsia': isFuchsia,
      'isDesktop': isDesktop,
      'isDesktopWeb': isDesktopWeb,
      'isMobile': isMobile,
      'isMobileWeb': isMobileWeb,
      'isTablet': isTablet,
    };
  }

  // ------------------------------------------
  // METHOD: toString
  // ------------------------------------------

  @override
  String toString() {
    return 'AppTargetInfo(${toJson()})';
  }
}
