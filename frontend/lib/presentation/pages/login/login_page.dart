import 'package:events_platform_frontend/core/services/custom_tabs_service.dart';
import 'package:events_platform_frontend/presentation/viewmodels/auth_viewmodel.dart';
import "package:flutter/material.dart";
import 'package:events_platform_frontend/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../../core/services/api_service.dart';
import '../home/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // App Name
            Text("Events Platform", style: TextStyle(fontSize: 36)),
            SizedBox(height: 50),
            // Logo
            IconButton(
                icon: Icon(Icons.remove_red_eye),
                iconSize: 90,
                onPressed: () {
                }),
            SizedBox(
              height: 100,
            ),
            // Google Sign In button
            ElevatedButton(
              onPressed: () async {
                try {
                  // initiate backend oauth flow
                  Provider.of<AuthViewmodel>(context, listen:false).startOAuthFlow(context);
                } catch (e) {
                  print(e.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      "Log-In Failed!?",
                      style: TextStyle(fontSize: 32),
                    )),
                  );
                }
              },
              child: Text(
                "Google Sign In",
                style: TextStyle(color: Colors.black),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
