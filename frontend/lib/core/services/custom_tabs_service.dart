import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs_lite.dart';

class CustomTabLauncher {
  void launchGoogleAuthCustomTab(BuildContext context, String uri) async {
    final theme = Theme.of(context);
    try {
      await launchUrl(
        Uri.parse(uri),
        options: LaunchOptions(
          barColor: theme.colorScheme.surface,
          onBarColor: theme.colorScheme.onSurface,
          barFixingEnabled: false,
        ),
      );
    } catch (e) {
      // If the URL launch fails, an exception will be thrown. (For example, if no browser app is installed on the Android device.)
      debugPrint(e.toString());
    }
  }
}
