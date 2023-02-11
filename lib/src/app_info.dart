part of app_device;

// ==========================================
// CLASS: AppInfoBase
// ==========================================

/// Common class for all structures provided by [AppInfoData]
abstract class AppInfoBase {
  /// Represent results as JSON map
  Map<String, Object> toJson();

  /// Pretty print the JSON representation of the informational object
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

/// Object encapsulating the populated [AppPackageInfo], [AppPlatformInfo], and [AppTargetInfo] instances.
class AppInfoData {
  AppInfoData._({
    required this.package,
    required this.platform,
    required this.target,
  });

  /// Information about the installed package and version
  final AppPackageInfo package;

  /// Information about the platform for which the app was built
  final AppPlatformInfo platform;

  /// Information about the platform on which the app is currently executing
  final AppTargetInfo target;

  static Future<AppInfoData> get() async {
    WidgetsFlutterBinding.ensureInitialized();
    return AppInfoData._(
      package: AppPackageInfo._(
        data: await PackageInfo.fromPlatform(),
      ),
      platform: AppPlatformInfo._(
        data: await DeviceInfoPlugin().deviceInfo,
      ),
      target: AppTargetInfo._(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      ),
    );
  }
}

// ==========================================
// CLASS: AppInfo
// ==========================================

/// [InheritedWidget] to distribute [AppInfoData] to application widget tree
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
  static final isDesktopPlatform = kIsWeb
      ? false
      : (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

  /// Denotes app was built for a mobile platform
  static final isMobilePlatform =
      kIsWeb ? false : (Platform.isAndroid || Platform.isIOS);

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

  /// Returns an instance of [AppInfoData] from [AppInfo] InheritedWidget
  static AppInfoData of(BuildContext context) {
    final AppInfo? result =
        context.dependOnInheritedWidgetOfExactType<AppInfo>();
    assert(result != null, 'No AppInfo InheritedWidget found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(AppInfo oldWidget) => false;
}
