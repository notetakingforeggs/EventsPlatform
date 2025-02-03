import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/api/api_service.dart';
import './become_attendee_controller.dart';

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

    final BecomeAttendeeController _controller = BecomeAttendeeController();

    @override
    void initState() {
      super.initState();
    }

    @override
     Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Text("Network Actions", style: TextStyle(fontSize: 46),)),
              SizedBox(height: 60,),

              Padding(
                padding: const EdgeInsets.all(40.0),
                child: OutlinedButton(
                    onPressed: () {
                      print("Getting Events");
                      ApiService().getData("api/v1/events");
                    },
                    child: Text("get events")),
              ),
            ],
          ),
        );
     }
}

