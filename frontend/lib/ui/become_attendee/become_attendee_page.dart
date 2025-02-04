import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/app_event.dart';
import '../../services/api/api_service.dart';
import './become_attendee_provider.dart';
import 'package:provider/provider.dart';

class BecomeAttendeePage extends StatefulWidget {
  static const name = "BecomeAttendeePage";

  static final GoRoute route = GoRoute(
    path: '/$name',
    name: name,
    builder: (context, state) {
      return const BecomeAttendeePage();
    },
  );

  static Future navigate(BuildContext context) {
    return context.pushNamed(name);
  }

  const BecomeAttendeePage({super.key});

  @override
  State<BecomeAttendeePage> createState() => _BecomeAttendeePageState();
}

class _BecomeAttendeePageState extends State<BecomeAttendeePage> {

  final BecomeAttendeeProvider _controller = BecomeAttendeeProvider();

  @override
  void initState() {
    super.initState();
    // TODo unsure about this format, should i initialise under the controller?
    final futureEvents = _controller.getEvents();
    Provider.of<BecomeAttendeeProvider>(context, listen: false).getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Events")),
        body: Consumer<BecomeAttendeeProvider>(
        builder:(context, _controller, child)
    {
      if (_controller.events.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.start, // Updated for clarity
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Wrapped the ListView in an Expanded widget to make it scrollable
          Expanded(
            child: ListView.builder(
              itemCount: _controller.events.length,
              itemBuilder: (context, index) {
                // get the specific event corresponding to this card
                final event = _controller.events[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4, // Adds a shadow effect
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(event.name!),
                    subtitle: Text(event.description!),
                    trailing: OutlinedButton(
                      onPressed: () async {
                        bool success = await _controller.attendEvent(event.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(success
                                ? "Successfully attended the event!"
                                : "Failed to attend the event"),
                          ),
                        );
                      },
                      child: Text("Attend"),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Text(
              "Network Actions",
              style: TextStyle(fontSize: 46),
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: OutlinedButton(
              onPressed: () {
                print("Getting Events");
              },
              child: Text("get events"),
            ),
          ),
        ],
      );
    },
        ),
    );
  }
}