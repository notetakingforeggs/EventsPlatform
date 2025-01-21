import "package:events_platform_frontend/components/ColourChangingButton.dart";
import "package:events_platform_frontend/pages/login_page.dart";
import "package:events_platform_frontend/services/auth/auth_service.dart";
import "package:events_platform_frontend/table_calendar_example/events_example.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'junk0.dart';

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
      body: Junk0(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TableEventsExample()));
          }),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            print("index is $index");
          },
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                onPressed: () {
                  AuthService().signOut();
                  print("logging out");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              label: "search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.safety_check),
              label: "get req",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_sharp),
              label: "profile",
            ),
          ]),
    );
  }
}
