import 'dart:async';

import 'package:events_platform_frontend/data/repositories/auth_repository.dart';
import 'package:events_platform_frontend/presentation/pages/event_list_page/event_list_viewmodel.dart';
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

  // singleton behaviour, multiple classes needing to use this one instance
  final authRepository = AuthRepository();

  // The line below came with the firebase snippet, but may not be needed for now?
  // show defaultTargetPlatform, kIsWeb, TargetPlatform;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => EventListViewmodel()),
    ChangeNotifierProvider(create: (context) => AuthViewmodel(authRepository)),
    ChangeNotifierProvider(create: (context) => authRepository),
  ], child: const MyApp()));
}
  // final router = MyRouter().router(authRepository);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MyRouter().router(context.read()),
      debugShowCheckedModeBanner: false,
      theme: lightMode,

      // darkTheme: make a darkmode theme later and put it here
    );
  }
}
