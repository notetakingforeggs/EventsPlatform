import 'package:events_platform_frontend/presentation/pages/add_event/add_event_page.dart';
import 'package:events_platform_frontend/presentation/pages/event_list_page/event_list_page.dart';
import 'package:events_platform_frontend/presentation/pages/loading_page.dart';
import 'package:events_platform_frontend/presentation/pages/login/login_page.dart';
import 'package:events_platform_frontend/presentation/pages/login/login_page_viewmodel.dart';
import 'package:events_platform_frontend/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/auth_repository.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/viewmodels/auth_viewmodel.dart';

class MyRouter {
  GoRouter router(AuthRepository authRepository) => GoRouter(
        initialLocation: Routes.home,
        debugLogDiagnostics: true,
        redirect: _redirect,
        refreshListenable: authRepository,
        routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) => HomePage(),
          ),

          GoRoute(
            path: Routes.login,
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: Routes.eventListPage,
            builder: (context, state) => EventListPage(),
          ),
          GoRoute(
            path: Routes.addEventPage,
            builder: (context, state) => AddEventPage(),
          ),
          GoRoute(
            path: Routes.loading,
            builder: (context, state) => LoadingPage(),
          ),

        ],
      );

// From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
  Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    final authRepository = context.read<AuthRepository>();

    if(authRepository.isLoading){
      return Routes.login;
    }


    // Are we logging in? check for code in the query param
    Uri uri = state.uri;
    print("uri: $uri");
    String? authCode = uri.queryParameters["code"];
    // if we have a non-null auth code, we must be logging in/registering...
    if(authCode != null && authCode.isNotEmpty){
      // but wait, maybe we are already logged in, and there is a token stored in the frontend? check that first?


      // log in/register, and then check authentication status before continuing to page
    bool successfullyLoggedIn = await authRepository.logIn(authCode!);
    if(successfullyLoggedIn){
      print("✅ is authenticated, redirecting to home screen");
      return Routes.home;
    }
    print("❌ issue with authentication, try logging in");
    return Routes.login;
  }
    // there was no auth code so we are just checking if we are currently logged in
    else {
      bool loggedIn = await authRepository.isLoggedIn();
      if (!loggedIn) {
        return Routes.login;
      }
// if the user is logged in but still on the login page, or trying to navaigate to it?, send them to
// the home page
      final loggingIn = state.matchedLocation == Routes.login;
      if (loggingIn) {
        return Routes.home;
      }
    }
    return null;
  }
}
