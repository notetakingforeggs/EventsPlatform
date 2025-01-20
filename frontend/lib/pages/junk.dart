import "package:events_platform_frontend/components/ColourChangingButton.dart";
import "package:events_platform_frontend/pages/login_page.dart";
import "package:events_platform_frontend/services/auth/auth_service.dart";
import "package:events_platform_frontend/table_calendar_example/events_example.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class Junk extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  Junk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Events Platform"),
      ),
      body: Container(
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
                                child: Text("sometext"),
                                onPressed: () {
                                  print("outlinedButton");
                                  User? user = AuthService().getCurrentUser();
                                  print(user);
                                }),
                          ],
                        ),
                      ),
                    ]),
                    Icon(Icons.accessible_rounded),
                  ]),
              FloatingActionButton(
                  child: Icon(Icons.add_a_photo),
                  onPressed: () {
                    print("floating action button");
                    print(user);
                  }),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TableEventsExample()));
          }),
      bottomNavigationBar: BottomNavigationBar(items:  [
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onPressed: () {
              AuthService().signOut();
              print("logging out");
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          label: "search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "map",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_sharp),
          label: "profile",
        ),
      ]),
    );
  }
}
