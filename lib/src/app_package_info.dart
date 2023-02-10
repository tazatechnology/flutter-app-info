part of app_device;

// ==========================================
// CLASS: AppPackageInfo
// ==========================================

/// Object encapsulating information about the installed package and version.
class AppPackageInfo extends AppInfoBase {
  AppPackageInfo._(this._info) {
    appName = _info.appName;
    buildSignature = _info.buildSignature;
    installerStore = _info.installerStore;
    version = Version.parse('${_info.version}+${_info.buildNumber}');
    versionWithoutBuild = Version.parse(_info.version);
  }
  final PackageInfo _info;

  /// The app name
  late final String appName;

  /// The build signature
  late final String buildSignature;

  /// The installer store
  late final String? installerStore;

  /// The package version
  late final Version version;

  /// The package version without the build
  late final Version versionWithoutBuild;

  // ------------------------------------------
  // METHOD: get
  // ------------------------------------------

  static Future<AppPackageInfo> get() async {
    WidgetsFlutterBinding.ensureInitialized();
    return AppPackageInfo._(await PackageInfo.fromPlatform());
  }

  // ------------------------------------------
  // METHOD: toJson
  // ------------------------------------------

  // Represent results as JSON map
  @override
  Map<String, Object> toJson() {
    return {
      'appName': appName,
      'buildSignature': buildSignature,
      'installerStore': installerStore,
      'version': version,
      'versionWithoutBuild': versionWithoutBuild,
    }.map((key, value) => MapEntry(key, value.toString()));
  }

  // ------------------------------------------
  // METHOD: toString
  // ------------------------------------------

  @override
  String toString() {
    return 'AppPackageInfo(${toJson()})';
  }
}
