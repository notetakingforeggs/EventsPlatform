import "package:flutter/material.dart";
import 'package:events_platform_frontend/services/auth/auth_service.dart';

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
            Icon(
              Icons.calendar_view_week_sharp,
              size: 90,
            ),
            SizedBox(
              height: 100,
            ),
            // Google Sign In button
            ElevatedButton(
              onPressed: () => AuthService().signInWithGoogle(),
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
