part of app_device;

// ==========================================
// CLASS: AppPackageInfo
// ==========================================

class AppPackageInfo extends AppInfoBase {
  AppPackageInfo._(this._info) {
    appName = _info.appName;
    buildSignature = _info.buildSignature;
    installerStore = _info.installerStore;
    version = Version.parse('${_info.version}+${_info.buildNumber}');
    versionWithoutBuild = Version.parse(_info.version);
  }
  final PackageInfo _info;
  late final String appName;
  late final String buildSignature;
  late final String? installerStore;
  late final Version version;
  late final Version versionWithoutBuild;

  // ------------------------------------------
  // METHOD: fetch
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
