part of app_device;

// ==========================================
// CLASS: AppTargetInfo
// ==========================================

class AppTargetInfo extends AppInfoBase {
  AppTargetInfo._();

  final TargetPlatform defaultPlatform = defaultTargetPlatform;
  final bool isWeb = kIsWeb;
  final bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
  final bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
  final bool isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
  final bool isLinux = defaultTargetPlatform == TargetPlatform.linux;
  final bool isWindows = defaultTargetPlatform == TargetPlatform.windows;
  final bool isFuchsia = defaultTargetPlatform == TargetPlatform.fuchsia;
  final bool isDesktop = AppInfo.isDesktopTarget;
  late final bool isDesktopWeb = AppInfo.isDesktopWebTarget;
  final bool isMobile = AppInfo.isMobileTarget;
  late final bool isMobileWeb = AppInfo.isMobileWebTarget;

  // ------------------------------------------
  // METHOD: fetch
  // ------------------------------------------

  static Future<AppTargetInfo> get() async {
    return AppTargetInfo._();
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
