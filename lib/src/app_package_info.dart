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
    if (_info.buildNumber.isNotEmpty) {
      version = Version.parse('${_info.version}+${_info.buildNumber}');
    } else {
      version = Version.parse(_info.version);
    }
    versionWithoutBuild = Version.parse(_info.version);
  }
  late final PackageInfo _info;

  /// The app name
  late final String appName;

  /// The package name
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
  Map<String, String> toJson() {
    return {
      'appName': appName,
      'packageName': packageName,
      'buildSignature': buildSignature,
      'installerStore': installerStore,
      'version': version,
      'versionWithoutBuild': versionWithoutBuild,
    }.map((key, value) => MapEntry(key, value.toString()));
  }
}
