import 'dart:async';

import 'package:events_platform_frontend/pages/http_playground.dart';
import 'package:events_platform_frontend/pages/junk.dart';
import 'package:events_platform_frontend/pages/login_page.dart';
import 'package:events_platform_frontend/services/auth/auth_service.dart';
import 'package:events_platform_frontend/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // The line below came with the firebase snippet, but may not be needed for now?
  // show defaultTargetPlatform, kIsWeb, TargetPlatform;
  runApp(const MyApp());
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {

        print("uri: ${state.uri}");
        Uri uri = state.uri;
        print(uri);
        String? code = uri.queryParameters["code"];
        String? email = uri.queryParameters["email"];
        print("code: $code");
        print("email: $email");

        if(code!=null){
            AuthService().sendAuthCodeToBackend(code);
        }else{
          print("no code after login on attempted navigation to homescreen?");
          return Junk();
        }

        return  LoginPage();
      },
      routes: [
        GoRoute(
          path: '/junk',
          builder: (context, state) => Junk(),
        ),
      ],
    ),
    GoRoute(
      path: '/junk',
      builder: (context, state) => Junk(),
    ),GoRoute(
      path: '/http',
      builder: (context, state) => HttpPlayground(),
    ),

  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: lightMode,

      // darkTheme: make a darkmode theme later and put it here
    );
  }
}
