import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './add_event_controller.dart';

class AddEventPage extends StatefulWidget {
  static const name = "AddEventPage";

  static final GoRoute route = GoRoute(
    path: "/$name",
    name: name,
    builder: (context, state) {
      return const AddEventPage();
    },
  );

  static Future navigate(BuildContext context) {
    return context.pushNamed(name);
  }

  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final AddEventController _controller = AddEventController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: ElevatedButton(
                onPressed: () {
                  context.push('/');
                },
                child: Text("Home")),
          ),
        ],
      ),
    );
  }
}
