import 'dart:async';

import 'package:events_platform_frontend/ui/add_event/add_event_page.dart';
import 'package:events_platform_frontend/ui/become_attendee/become_attendee_page.dart';
import 'package:events_platform_frontend/ui/become_attendee/become_attendee_provider.dart';
import 'package:events_platform_frontend/ui/http_playground.dart';
import 'package:events_platform_frontend/ui/junk.dart';
import 'package:events_platform_frontend/ui/login_page.dart';
import 'package:events_platform_frontend/services/auth/auth_service.dart';
import 'package:events_platform_frontend/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // The line below came with the firebase snippet, but may not be needed for now?
  // show defaultTargetPlatform, kIsWeb, TargetPlatform;

  runApp(ChangeNotifierProvider(
      create: (context) => BecomeAttendeeProvider(), child: const MyApp()));
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        //Future<bool> isLoggedIn = AuthService().isLoggedIn();
        Uri uri = state.uri;
        print("uri: $uri}");
        String? code = uri.queryParameters["code"];
        // future builder to get the result of an async function to be able to use it in a non async function?
        // first check if the user is logged in by checking the exp of any jwt
        return FutureBuilder(
          future: code != null
              ? AuthService().sendAuthCodeToBackend(code) // handle login
              : AuthService().isLoggedIn(), // check if already logged in
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // TODO why is my progress indicator stretching to fill the whole screen?
              return Center(
                  child: SizedBox(
                      width: 40, height: 40, child: LinearProgressIndicator()));
            }
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            bool isAuthenticated = snapshot.data ??
                false; // this line works for either scenario of the ternary above, as snapshot.data will refer to the output of whichever function is the target of the future builder depending whether or not there is an auth chode
            // TODO issue with this logic, i think it is running sendAuthCodeToBackend when it should be only doing that if it is not logged in?
            // TODO also this should be refactored into a controller to deal with state and prevent repeated calls to authservice on rebuild
            // TODO definitely sending the auth code again when i navigate to home by pressing back button after form... idkk
            // if is logged in (based on active token in secure storage)
            if (isAuthenticated) {
              code = null;
              print("✅ is authenticated, redirecting to home screen");
              return (Junk());
            }
            print("❌ issue with authentication, try logging in");
            return LoginPage();
          },
        );
      },
    ),
    GoRoute(
      path: '/junk',
      builder: (context, state) => Junk(),
    ),
    GoRoute(
      path: '/http',
      builder: (context, state) => HttpPlayground(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, statue) => LoginPage(),
    ),
    GoRoute(
      path: '/BecomeAttendeePage',
      builder: (context, statue) => BecomeAttendeePage(),
    ),
    GoRoute(
      path: '/AddEventPage',
      builder: (context, statue) => AddEventForm(),
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
