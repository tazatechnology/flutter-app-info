/// Primary library for accessing [AppInfo] and [AppInfoData]
library flutter_app_info;

import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_app_info/src/index.dart';

export 'package:version/version.dart' show Version;

export 'src/index.dart'
    show AppInfo, AppInfoData, AppPackageInfo, AppPlatformInfo, AppTargetInfo;
