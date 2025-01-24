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
                  print("printing");
                  User? user = AuthService().getCurrentUser();
                  print(user);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      "something",
                      style: TextStyle(fontSize: 32),
                    )),
                  );
                }),
            SizedBox(
              height: 100,
            ),
            // Google Sign In button
            ElevatedButton(
              onPressed: () async {
                try {
                  final Map<String, dynamic> signInResult = await AuthService().signInWithGoogle();
                 print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@token: ${signInResult["accessToken"]}");
                  await  ApiService().postUser();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Junk()));
                } catch (e) {
                  print(e);
                  print("Pppppppppppppppppppppp");
                }

                //   print("flim");
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //         content: Text(
                //       "LogInFailed... but why?",
                //       style: TextStyle(fontSize: 32),
                //     )),
                //   );
                // }
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
