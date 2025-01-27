import 'package:events_platform_frontend/pages/junk.dart';
import 'package:events_platform_frontend/pages/login_page.dart';
import 'package:events_platform_frontend/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:app_links/app_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // The line below came with the firebase snippet, but may not be needed for now?
  // show defaultTargetPlatform, kIsWeb, TargetPlatform;
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  String? _deepLink;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // handle initial deep link (from closed state)
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      print("Initial deep link received: $initialUri");
      _handleDeepLink(initialUri);
    }

    // listening for deep links coming in
    _appLinks.uriLinkStream.listen((Uri uri) {
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) {
    setState(() {
      _deepLink = uri.toString();
    });
    print("uri: $uri");
    print("uri host: ${uri.host}");

    if (uri.host == 'junk') {
      print("deep link received: $uri");
      _navigatorKey.currentState?.pushReplacementNamed('/junk');
    } else {
      print("uri path is not correct");
    }
  }




@override
Widget build(BuildContext context) {
  return MaterialApp(
    navigatorKey: _navigatorKey,
    routes: ({
      '/junk': (context) => Junk(),
    }),
    scaffoldMessengerKey:
    GlobalKey<ScaffoldMessengerState>(),
    debugShowCheckedModeBanner: false,
    home: const LoginPage(),
    theme: lightMode,
    // darkTheme: make a darkmode theme later and put it here
  );
}

}



