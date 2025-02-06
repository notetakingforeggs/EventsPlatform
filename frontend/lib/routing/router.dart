import 'package:events_platform_frontend/presentation/pages/add_event/add_event_page.dart';
import 'package:events_platform_frontend/presentation/pages/event_list_page/event_list_page.dart';
import 'package:events_platform_frontend/presentation/pages/home/http_playground.dart';
import 'package:events_platform_frontend/presentation/pages/login/login_page.dart';
import 'package:events_platform_frontend/presentation/pages/login/login_page_viewmodel.dart';
import 'package:events_platform_frontend/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/auth_repository.dart';

/// Top go_router entry point.
///
/// Listens to changes in [AuthTokenRepository] to redirect the user
/// to /login when the user logs out.
GoRouter router(
  AuthRepository authRepository,
) =>
    GoRouter(
      initialLocation: Routes.home,
      debugLogDiagnostics: true,
      redirect: _redirect,
      refreshListenable: authRepository,
      routes: [
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
  final loggedIn = await context.read<AuthRepository>().isAuthenticated;
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
