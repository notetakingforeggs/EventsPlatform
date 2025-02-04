import 'package:events_platform_frontend/services/custom_tabs/custom_tabs_1.dart';
import 'package:events_platform_frontend/ui/become_attendee/become_attendee_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/ColourChangingButton.dart';
import '../services/auth/auth_service.dart';

class Playground extends StatelessWidget {
  Playground({super.key});

  // User? user;

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
                    context.push('/AddEventPage');
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
                                child: Text("nothing"),
                                onPressed: () {
                                  print("outlinedButton");

                                }),
                          ],
                        ),
                      ),
                    ]),
                    IconButton(
                      icon: Icon(Icons.accessible_rounded),
                      onPressed: () {
                        print("going to become attendee");
                        context.push('/BecomeAttendeePage');

                      },
                    ),
                  ]),
              FloatingActionButton(
                  child: Icon(Icons.add_a_photo),
                  onPressed: () {
                    print("floating action button");
                  },
                heroTag: "printUser",
              ),

            ]));
  }
}
