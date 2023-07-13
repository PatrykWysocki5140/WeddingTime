import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppVersionWidgetState createState() => _AppVersionWidgetState();
}

class _AppVersionWidgetState extends State<AppVersion> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '${AppLocalizations.of(context)!.version}: ${snapshot.data!.version}',
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
