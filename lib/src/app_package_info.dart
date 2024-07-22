part of 'index.dart';

// ==========================================
// CLASS: AppPackageInfo
// ==========================================

/// Object encapsulating information about the installed package and version.
class AppPackageInfo extends AppInfoBase {
  AppPackageInfo._({required PackageInfo data}) {
    _info = data;
    appName = _info.appName;
    packageName = _info.packageName;
    buildSignature = _info.buildSignature;
    installerStore = _info.installerStore;
    version = Version.parse('${_info.version}+${_info.buildNumber}');
    versionWithoutBuild = Version.parse(_info.version);
  }
  late final PackageInfo _info;

  /// The app name
  late final String appName;

  /// The app package name
  late final String packageName;

  /// The build signature
  late final String buildSignature;

  /// The installer store
  late final String? installerStore;

  /// The package version
  late final Version version;

  /// The package version without the build
  late final Version versionWithoutBuild;

  // ------------------------------------------
  // METHOD: toJson
  // ------------------------------------------

  /// Represent results as JSON map
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
}
