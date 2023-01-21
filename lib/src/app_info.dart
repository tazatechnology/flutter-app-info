part of app_device;

// ==========================================
// CLASS: AppInfoBase
// ==========================================

/// Common class for all structures provided by [AppInfoData]
abstract class AppInfoBase {
  // Represent results as JSON map
  Map<String, Object> toJson();

  // Pretty print the JSON representation of the informational object
  void prettyPrint() {
    var encoder = const JsonEncoder.withIndent('  ');
    final data = toJson();
    for (final k in data.keys) {
      if (data[k] is Map) {
        data[k] = encoder.convert(toJson());
      }
    }
    // ignore: avoid_print
    print(encoder.convert(toJson()));
  }
}

// ==========================================
// CLASS: AppInfoData
// ==========================================

/// Container data class with structured package, platform, and target information
class AppInfoData {
  AppInfoData._({
    required this.package,
    required this.platform,
    required this.target,
  });
  final AppPackageInfo package;
  final AppPlatformInfo platform;
  final AppTargetInfo target;

  static Future<AppInfoData> get() async {
    WidgetsFlutterBinding.ensureInitialized();
    return AppInfoData._(
      package: await AppPackageInfo.get(),
      platform: await AppPlatformInfo.get(),
      target: await AppTargetInfo.get(),
    );
  }
}

// ==========================================
// CLASS: AppInfo
// ==========================================

/// [InheritedWidget] to distributed [AppInfoData] to application widget tree
class AppInfo extends InheritedWidget {
  const AppInfo({
    super.key,
    required this.data,
    required super.child,
  });

  /// Instance of [AppInfoData] provided by [AppInfo] [InheritedWidget]
  final AppInfoData data;

  /// Denotes app was built for web, same as [kIsWeb]
  // ignore: prefer_const_declarations
  static final isWeb = kIsWeb;

  /// Denotes app was built for a desktop platform
  static final isDesktopPlatform = kIsWeb ? false : (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

  /// Denotes app was built for a mobile platform
  static final isMobilePlatform = kIsWeb ? false : (Platform.isAndroid || Platform.isIOS);

  /// Denotes app is running for a desktop target
  static final isDesktopTarget = [
    TargetPlatform.linux,
    TargetPlatform.macOS,
    TargetPlatform.windows,
  ].contains(defaultTargetPlatform);

  /// Denotes app was built for web and is running on a desktop browser
  static final isDesktopWebTarget = isWeb && isDesktopTarget;

  /// Denotes app is running for a mobile target
  static final isMobileTarget = [
    TargetPlatform.iOS,
    TargetPlatform.android,
  ].contains(defaultTargetPlatform);

  /// Denotes app was built for web and is running on a mobile browser
  static final isMobileWebTarget = isWeb && isMobileTarget;

  static AppInfo? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppInfo>();
  }

  static AppInfoData of(BuildContext context) {
    final AppInfo? result = maybeOf(context);
    assert(result != null, 'No AppInfo InheritedWidget found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(AppInfo oldWidget) => false;
}
