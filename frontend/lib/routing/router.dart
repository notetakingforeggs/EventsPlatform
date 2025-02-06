import 'package:events_platform_frontend/presentation/pages/add_event/add_event_page.dart';
import 'package:events_platform_frontend/presentation/pages/event_list_page/event_list_page.dart';
import 'package:events_platform_frontend/presentation/pages/home/http_playground.dart';
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
  GoRouter router(AuthRepository authRepository,) =>
      GoRouter(
        initialLocation: Routes.home,
        debugLogDiagnostics: true,
        redirect: _redirect,
        refreshListenable: authRepository,
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) {
              //Future<bool> isLoggedIn = AuthService().isLoggedIn();
              Uri uri = state.uri;
              print("uri: $uri}");
              String? authCode = uri.queryParameters["code"];
              final authViewModel =
              Provider.of<AuthViewmodel>(context, listen: false);
              // future builder to get the result of an async function to be able to use it in a non async function?
              // first check if the user is logged in by checking the exp of any jwt
              return FutureBuilder(
                future: authViewModel.checkAuthentication(authCode),
                // check if already logged in
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: LinearProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  if (authViewModel.isAuthenticated) {
                    print("✅ is authenticated, redirecting to home screen");
                    return (HomePage());
                  }
                  print("❌ issue with authentication, try logging in");
                  return LoginPage();
                },
              );
            },
          ),
          GoRoute(
            path: Routes.login,
            builder: (context, state) {
              return LoginPage(
                // viewModel: LoginPageViewmodel(
                //   authRepository: context.read(),
              );
            },
          ),
          GoRoute(
            path: Routes.httplayground,
            builder: (context, state) => HttpPlayground(),
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
        ],
      );

// From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
  Future<String?> _redirect(BuildContext context, GoRouterState state) async {
// if the user is not logged in, they need to login
    final loggedIn = await context
        .read<AuthRepository>()
        .isLoggedIn();
    final loggingIn = state.matchedLocation == Routes.login;
    if (!loggedIn) {
      return Routes.login;
    }

// if the user is logged in but still on the login page, send them to
// the home pagechangenotifier
    if (loggingIn) {
      return Routes.home;
    }
    return null;
  }
}