import 'dart:async';

import 'package:events_platform_frontend/data/providers/loading_provider.dart';
import 'package:events_platform_frontend/data/repositories/auth_repository.dart';
import 'package:events_platform_frontend/presentation/pages/add_event/add_event_viewmodel.dart';
import 'package:events_platform_frontend/presentation/pages/event_list_page/event_list_viewmodel.dart';
import 'package:events_platform_frontend/presentation/pages/home/home_viewmodel.dart';
import 'package:events_platform_frontend/presentation/pages/loading_overlay.dart';
import 'package:events_platform_frontend/presentation/viewmodels/auth_viewmodel.dart';
import 'package:events_platform_frontend/routing/router.dart';
import 'package:events_platform_frontend/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoadingProvider()),
    ChangeNotifierProvider(
        create: (context) => AuthRepository(context.read<LoadingProvider>())),
    //the above line and below do the same, but do like the former in multiprovider, and the below in widgets.
    // ChangeNotifierProvider(create: (context) => AuthRepository(Provider.of<LoadingProvider>(context, listen:false))),
    ChangeNotifierProvider(
        create: (context) =>
            AuthViewmodel(Provider.of<AuthRepository>(context, listen: false))),
    ChangeNotifierProvider(
        create: (context) =>
            EventListViewmodel(context.read<LoadingProvider>())),
    ChangeNotifierProvider(create: (context) => AddEventViewmodel()),
    ChangeNotifierProvider(create: (context) => HomeViewModel()),
  ], child: const MyApp()));
}
// final router = MyRouter().router(authRepository);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MyRouter().router(context.read<AuthRepository>()),
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            // Consumer ensures only loading overlay rebuilds
            Consumer<LoadingProvider>(
              builder: (context, loadingProvider, _) {
                if (!loadingProvider.isLoading) return const SizedBox.shrink();
                return const LoadingOverlay();
              },
            ),
          ],
        );
      },
    );
  }
}



