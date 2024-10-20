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
    installerStore = _info.installerStore;
    buildSignature = _info.buildSignature;
    buildNumber = _info.buildNumber;
    // Define the complete version string
    String versionString;
    if (buildNumber.isNotEmpty) {
      versionString = '${_info.version}+$buildNumber';
    } else {
      versionString = _info.version;
    }
    // Parse version (may contain build)
    try {
      version = Version.parse(versionString);
    } catch (e) {
      version = Version.parse('0');
      if (kDebugMode) {
        print('Error parsing package version ("$versionString") - $e');
      }
    }
    // Parse version without build
    try {
      versionWithoutBuild = Version.parse(_info.version);
    } catch (e) {
      versionWithoutBuild = Version.parse('0');
      if (kDebugMode) {
        print('Error parsing package version ("${_info.version}") - $e');
      }
    }
  }
  late final PackageInfo _info;

  /// The app name
  late final String appName;

  /// The package name
  late final String packageName;

  /// The installer store
  late final String? installerStore;

  /// The build signature
  late final String buildSignature;

  /// The package build number
  late final String buildNumber;

  /// The package version - as a [Version] object
  late final Version version;

  /// The package version without the build - as a [Version] object
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
