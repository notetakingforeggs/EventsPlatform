import 'package:events_platform_frontend/presentation/pages/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../routing/routes.dart';
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
  @override
  void initState() {
    super.initState();
    // post frame callback schedules the data fetch for after the initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventListViewmodel>().getEvents();
    });

  }

  @override
  Widget build(BuildContext context) {
    EventListViewmodel eventListViewmodel =
        Provider.of<EventListViewmodel>(context, listen: false);
    HomeViewModel homeViewModel = context.read<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text("Events")),
      body: Consumer<EventListViewmodel>(
        builder: (context, _controller, child) {
          if (_controller.events.isEmpty) {
            // return Center(child: CircularProgressIndicator());
            return Center(child: Text("No events found"));
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
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From ${event.startDate}, ${event.startTime}',
                            ),
                            Text(
                              'To ${event.endDate}, ${event.endTime}',
                            ),
                            Flexible(
                              child: OutlinedButton(
                                onPressed: () async {
                                  bool success =
                                      await _controller.attendEvent(event.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(success
                                          ? "This event has been added to your calendar!"
                                          : "Failed to attend the event"),
                                    ),
                                  );
                                  context.read<HomeViewModel>().currentIndex = 0;
                                  Navigator.pop(context);
                                },
                                child: Text("Attend"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
