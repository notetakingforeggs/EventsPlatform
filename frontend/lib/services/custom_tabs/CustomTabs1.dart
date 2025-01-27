import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs_lite.dart';


void launchURLL(BuildContext context) async {
  final theme = Theme.of(context);
  try {
    await launchUrl(
      Uri.parse('https://accounts.google.com/o/oauth2/v2/auth?client_id=8374014814-f2ql0dltfnijdfdc74487qhq6u2ooocd.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fapi%2Fv1%2Foauth2%2Fcallback&response_type=code&scope=openid+profile+email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar&access_type=offline'),
      // Uri.parse('https://www.google.com'),
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