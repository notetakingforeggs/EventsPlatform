import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/ColourChangingButton.dart';
import '../services/auth/auth_service.dart';

class Playground extends StatelessWidget {
  Playground({super.key});

  User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    print("elevated button");
                  },
                  child: Icon(
                    Icons.access_alarm_outlined,
                    color: Colors.black,
                  )),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ColourChangingButton(),
                    Stack(children: [
                      Container(
                        width: 200,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                20,
                                0,
                                20,
                                0,
                              ),
                              child: Icon(Icons.panorama_fish_eye),
                            ),
                            OutlinedButton(
                                child: Text("User info"),
                                onPressed: () {
                                  print("outlinedButton");
                                  user = AuthService().getCurrentUser();
                                  print(user);
                                }),
                          ],
                        ),
                      ),
                    ]),
                    IconButton(
                      icon: Icon(Icons.accessible_rounded),
                      onPressed: () {
                        print("get OAuth Access token");
                        AuthService().getOAuthAccessToken();

                      },
                    ),
                  ]),
              FloatingActionButton(
                  child: Icon(Icons.add_a_photo),
                  onPressed: () {
                    print("floating action button");
                    print(user);
                  }),
            ]));
  }
}
