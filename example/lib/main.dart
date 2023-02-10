import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';

// ==========================================
// MAIN
// ==========================================

void main() async {
  runApp(
    AppInfo(
      data: await AppInfoData.get(),
      child: const MyApp(),
    ),
  );
}

// ==========================================
// CLASS: MyApp
// ==========================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter App Info',
      debugShowCheckedModeBanner: false,
      home: FlutterAppInfoExample(),
    );
  }
}

// ==========================================
// CLASS: FlutterAppInfoExample
// ==========================================

class FlutterAppInfoExample extends StatefulWidget {
  const FlutterAppInfoExample({super.key});

  @override
  State<FlutterAppInfoExample> createState() => _FlutterAppInfoExampleState();
}

class _FlutterAppInfoExampleState extends State<FlutterAppInfoExample>
    with SingleTickerProviderStateMixin {
  late final controller = TabController(vsync: this, length: 3);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          controller: controller,
          tabs: [
            const Text('Package Info'),
            const Text('Platform Info'),
            const Text('Target Info'),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: e,
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          PackageInfoTab(),
          PlatformInfoTab(),
          TargetInfoTab(),
        ],
      ),
    );
  }
}

// ==========================================
// CLASS: Prop
// ==========================================

class Prop {
  Prop(this.prop, Object? value) {
    this.value = value.toString().isEmpty ? "''" : value.toString();
  }
  final String prop;
  late final String value;
}

// ==========================================
// CLASS: PropTable
// ==========================================

class PropTable extends StatelessWidget {
  const PropTable({
    super.key,
    required this.title,
    required this.children,
  });
  final String title;
  final List<Prop> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: SelectionArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: IntrinsicColumnWidth(flex: 1),
                1: FlexColumnWidth(2),
              },
              children: children
                  .map(
                    (e) => TableRow(
                      decoration: BoxDecoration(
                        color: children.indexOf(e).isEven
                            ? Colors.grey.shade200
                            : Theme.of(context).scaffoldBackgroundColor,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            e.prop,
                            style: const TextStyle(
                              fontFamily: 'Verdana',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            e.value,
                            style: const TextStyle(
                              fontFamily: 'Verdana',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// CLASS: PackageInfoTab
// ==========================================

class PackageInfoTab extends StatelessWidget {
  const PackageInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final package = AppInfo.of(context).package;

    return PropTable(
      title: 'Information about the installed package and version',
      children: [
        Prop('appName', package.appName),
        Prop('buildSignature', package.buildSignature),
        Prop('installerStore', package.installerStore),
        Prop('version', package.version.toString()),
        Prop('versionWithoutBuild', package.versionWithoutBuild.toString()),
      ],
    );
  }
}

// ==========================================
// CLASS: PlatformInfoTab
// ==========================================

class PlatformInfoTab extends StatelessWidget {
  const PlatformInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = AppInfo.of(context).platform;
    var encoder = const JsonEncoder.withIndent('  ');
    return PropTable(
      title: 'Information about the platform for which the app was built',
      children: [
        Prop('isAndroid', platform.isAndroid),
        Prop('isIOS', platform.isIOS),
        Prop('isLinux', platform.isLinux),
        Prop('isMacOS', platform.isMacOS),
        Prop('isWeb', platform.isWeb),
        Prop('isWindows', platform.isWindows),
        Prop('isFuchsia', platform.isFuchsia),
        Prop('isDesktop', platform.isDesktop),
        Prop('isMobile', platform.isMobile),
        Prop('device', encoder.convert(platform.device.data)),
        Prop('executable', platform.executable),
        Prop('resolvedExecutable', platform.resolvedExecutable),
        Prop('executableArguments', platform.executableArguments),
        Prop('localHostname', platform.localHostname),
        Prop('localeName', platform.localeName),
        Prop('numberOfProcessors', platform.numberOfProcessors),
        Prop('operatingSystem', platform.operatingSystem),
        Prop('operatingSystemVersion', platform.operatingSystemVersion),
        Prop('packageConfig', platform.packageConfig),
        Prop('pathSeparator', platform.pathSeparator),
        Prop('script', platform.script),
        Prop('version', platform.version),
        Prop('environment', 'Map<String, String>'),
      ],
    );
  }
}

// ==========================================
// CLASS: TargetInfoTab
// ==========================================

class TargetInfoTab extends StatelessWidget {
  const TargetInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final target = AppInfo.of(context).target;

    return PropTable(
      title:
          'Information about the platform on which the app is currently executing',
      children: [
        Prop('defaultPlatform', target.defaultPlatform),
        Prop('isAndroid', target.isAndroid),
        Prop('isIOS', target.isIOS),
        Prop('isLinux', target.isLinux),
        Prop('isMacOS', target.isMacOS),
        Prop('isWeb', target.isWeb),
        Prop('isWindows', target.isWindows),
        Prop('isFuchsia', target.isFuchsia),
        Prop('isDesktop', target.isDesktop),
        Prop('isDesktopWeb', target.isDesktopWeb),
        Prop('isMobile', target.isMobile),
        Prop('isMobileWeb', target.isMobileWeb),
      ],
    );
  }
}
