import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'event_list_viewmodel.dart';

class EventListPage extends StatefulWidget {
  static const name = "EventListPage";

  static final GoRoute route = GoRoute(
    path: '/$name',
    name: name,
    builder: (context, state) {
      return const EventListPage();
    },
  );

  static Future navigate(BuildContext context) {
    return context.pushNamed(name);
  }

  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {

  final EventListViewmodel _controller = EventListViewmodel();

  @override
  void initState() {
    super.initState();
    // TODo unsure about this format, should i initialise under the controller?
    final futureEvents = _controller.getEvents();
    Provider.of<EventListViewmodel>(context, listen: false).getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Events")),
        body: Consumer<EventListViewmodel>(
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