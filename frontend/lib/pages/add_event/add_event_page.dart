import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './add_event_controller.dart';

class AddEventForm extends StatefulWidget {
  static const name = "AddEventPage";

  static final GoRoute route = GoRoute(
    path: "/$name",
    name: name,
    builder: (context, state) {
      return const AddEventForm();
    },
  );

  static Future navigate(BuildContext context) {
    return context.pushNamed(name);
  }

  const AddEventForm({super.key});

  @override
  State<AddEventForm> createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  // TODO move some stuff into the controller?
  final AddEventController _controller = AddEventController();

  // a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new event.'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Event Name",
                  hintText: "type the name of your event here",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                ),
                validator: (value) {
                  return AddEventController().nameValidator(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Event Details',
                    hintText: "put in some event deets",
                    hintStyle: TextStyle(color: Colors.blueGrey)),
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                minLines: 1,
                validator: (value) {
                  return AddEventController().nameValidator(value);
                },
              ),
              // TODO gonna code this up as text input but better to refactor with date and time pickers
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Start Date',
                    hintText: "format is DD/MM/YY",
                    hintStyle: TextStyle(color: Colors.blueGrey)),
                validator: (value) {
                  return AddEventController().nameValidator(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Start Time',
                    hintText: "format is HH/MM 24h clock",
                    hintStyle: TextStyle(color: Colors.blueGrey)),
                validator: (value) {
                  return AddEventController().nameValidator(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'End Date',
                    hintText: "format is DD/MM/YY",
                    hintStyle: TextStyle(color: Colors.blueGrey)),
                validator: (value) {
                  return AddEventController().nameValidator(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'End Time',
                    hintText: "format is HH/MM 24h clock",
                    hintStyle: TextStyle(color: Colors.blueGrey)),
                validator: (value) {
                  return AddEventController().nameValidator(value);
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // call apiservice method to send the deetails
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Submitting Form Data')),
                      );
                      context.push('/');
                    }
                  },
                  child: Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
// example event

//('Trampoline Conference', '2025-05-01T10:00:00Z', '2025-05-01T18:00:00Z'),
