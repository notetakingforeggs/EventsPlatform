import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './add_event_viewmodel.dart';

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
  // TODO move some stuff into the controller?
  final AddEventViewmodel _controller = AddEventViewmodel();
  final _formKey = AddEventViewmodel().getFormKey();

// i put the form key in the controller, and will reference it through that
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
              // TODO could make a custom text form field label to remove having to put the hintstyle all the time
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Event Name",
                  hintText: "type the name of your event here",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                ),
                validator: (value) {
                  return AddEventViewmodel().nameValidator(value);
                },
                onSaved: (value) {
                  _controller.saveData("event_name", value);
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
                  return AddEventViewmodel().nameValidator(value);
                },
                onSaved: (value) {
                  _controller.saveData("description", value);
                },
              ),
              // TODO gonna code this up as text input but better to refactor with date and time pickers
              // TODO not gonna do validation for date/time because of the above
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Start Date',
                    hintText: "format is DD/MM/YY",
                    hintStyle: TextStyle(color: Colors.blueGrey)),
                validator: (value) {
                  return _controller.nameValidator(value);
                },
                onSaved: (value) {
                  _controller.saveData("start_date", value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Start Time',
                    hintText: "format is HH:MM 24h clock",
                    hintStyle: TextStyle(color: Colors.blueGrey)),
                validator: (value) {
                  return _controller.nameValidator(value);
                },
                onSaved: (value) {
                  _controller.saveData("start_time", value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'End Date',
                    hintText: "format is DD/MM/YY",
                    hintStyle: TextStyle(color: Colors.blueGrey)),
                validator: (value) {
                  return _controller.nameValidator(value);
                },
                onSaved: (value) {
                  _controller.saveData("end_date", value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'End Time',
                    hintText: "format is HH:MM 24h clock",
                    hintStyle: TextStyle(color: Colors.blueGrey)),
                validator: (value) {
                  return _controller.nameValidator(value);
                },
                onSaved: (value) {
                  _controller.saveData("end_time", value);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _controller.submitForm();
                    // call apiservice method to send the deetails
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Submitting Form Data')),
                    );
                    // context.push('/');
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              FloatingActionButton(onPressed: () {
                context.push('/');
              })
            ],
          ),
        ),
      ),
    );
  }
}
// example event

//('Trampoline Conference', '2025-05-01T10:00:00Z', '2025-05-01T18:00:00Z'),
