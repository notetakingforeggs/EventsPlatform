import 'package:events_platform_frontend/services/custom_tabs/custom_tabs_1.dart';
import "package:flutter/material.dart";
import 'package:events_platform_frontend/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/api/api_service.dart';
import 'junk.dart';

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
                  User? user = AuthService().getCurrentUser();
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                        "not logged in",
                        style: TextStyle(fontSize: 32),
                      )),
                    );
                  } else {
                    print("current user details are: $user");
                  }
                }),
            SizedBox(
              height: 100,
            ),
            // Google Sign In button
            ElevatedButton(
              onPressed: () async {
                try {
                  // initiate sign in and store return values in memory to send to backend
                  // final Map<String, dynamic> signInResult =
                  //     await AuthService().signInWithGoogle();
                  //
                  //     // print("(99999999999999 ${signInResult["googleIdToken"]} ------------ ${signInResult["googleAccessToken"]}");
                  // await ApiService().postUser(signInResult["googleIdToken"], signInResult["googleAccessToken"]);

                  // initiate backend oauth flow
                  print("1");
                  await ApiService().initBackendOAuthFlow(context);
                  print("api stuff done");
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => Junk()));
                } catch (e) {
                  print(e.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      "LogInFailed... but why?",
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
