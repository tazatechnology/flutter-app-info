/// Primary library for accessing [AppInfo] and [AppInfoData]
library flutter_app_info;

export 'package:device_info_plus/device_info_plus.dart'
    show
        BaseDeviceInfo,
        WebBrowserInfo,
        AndroidDeviceInfo,
        IosDeviceInfo,
        LinuxDeviceInfo,
        MacOsDeviceInfo,
        WindowsDeviceInfo;

export 'package:version/version.dart' show Version;

export 'src/index.dart' show AppInfo, AppInfoData;
