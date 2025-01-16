import 'package:events_platform_frontend/pages/login_page.dart';
import 'package:events_platform_frontend/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // The line below came with the firebase snippet, but may not be needed for now?
  // show defaultTargetPlatform, kIsWeb, TargetPlatform;
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: lightMode,
      // darkTheme: make a darkmode theme later and put it here
    );
  }
}




// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
// //
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           backgroundColor: Colors.redAccent,
// //           title: const Text("Events Platform"),
// //         ),
// //         body: Container(
// //           color: Colors.grey,
// //           child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 Icon(Icons.access_alarm_outlined),
// //                 Column(
// //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       Icon(Icons.add_a_photo),
// //                       Stack(children: [
// //                         Container(
// //                           width: 200,
// //                           height: 75,
// //                           decoration: BoxDecoration(
// //                             color: Colors.purple,
// //                             borderRadius: BorderRadius.circular(15),
// //                           ),
// //                           child: const Row(
// //                             children: [
// //                               Padding(
// //                                 padding: const EdgeInsets.fromLTRB(
// //                                   20,
// //                                   0,
// //                                   20,
// //                                   0,
// //                                 ),
// //                                 child: Icon(Icons.panorama_fish_eye),
// //                               ),
// //                               Text("Google Sign In")
// //                             ],
// //                           ),
// //                         ),
// //                       ]),
// //                       Icon(Icons.accessible_rounded),
// //                     ]),
// //                 Icon(Icons.add_a_photo),
// //               ]),
// //         ),
// //         floatingActionButton: FloatingActionButton(
// //             child: Icon(Icons.add),
// //             onPressed: () {
// //               print("poop");
// //             }),
// //         bottomNavigationBar: BottomNavigationBar(items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.search),
// //             label: "search",
// //           ),BottomNavigationBarItem(icon: Icon(Icons.map),
// //             label: "map",
// //           ),BottomNavigationBarItem(icon: Icon(Icons.person_2_sharp),
// //             label: "profile",
// //           ),
// //         ]),
// //       ),
// //     );
// //   }
// // }
