import "package:events_platform_frontend/components/ColourChangingButton.dart";
import "package:events_platform_frontend/data/repositories/auth_repository.dart";
import "package:events_platform_frontend/presentation/pages/event_list_page/event_list_page.dart";
import "package:events_platform_frontend/presentation/pages/home/home_viewmodel.dart";
import "package:events_platform_frontend/presentation/pages/login/login_page.dart";
import "package:events_platform_frontend/core/services/auth_service.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import "package:provider/provider.dart";
import "../../../routing/routes.dart";
import "../table_calendar_example/events_example.dart";
import 'playground.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = context.read<HomeViewModel>();
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: const Text("Events Platform"),
              leading: BackButton(
                onPressed: () {
                  if (Navigator.canPop(context))
                    // TODO in here need to prevent popping the last screen to avoid black
                    Navigator.pop(context);
                },
              )),
          body: homeViewModel.homeScreens[homeViewModel.currentIndex],
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.exit_to_app),
              onPressed: () async {

                await context.read<AuthRepository>().logOut();
                context.push(Routes.login);

              }),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (int index) async {
                print("tapped index is $index");

                homeViewModel.currentIndex = index;
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fingerprint),
                  label: "Attend",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.plus_one),
                  label: "Create",
                ),
              ]),
        );
      },
    );
  }
}
