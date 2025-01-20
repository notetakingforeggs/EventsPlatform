import 'package:flutter/material.dart';

// extend a stateful widget
class ColourChangingButton extends StatefulWidget {
  // keys are not always needed but good practice to put there anyway (read more into later)
  const ColourChangingButton({Key? key}) : super(key: key);

  // every stateful widget must ovverride the createState method, It tells flutter which state class to use
  @override
  _ColourChangingButtonState createState() => _ColourChangingButtonState();
}

// here creating the state class that we then feed to our stateful widget
// every stateful widget must have a corresponding state class.
class _ColourChangingButtonState extends State<ColourChangingButton> {
  Color _buttonColor = Colors.blue; // Mutable state, as in, it is the variable that changes

  // color change logic
  void _toggleColor() {
    setState(() {
      // this is a ternary operator, assigning the outcome of the ternary to _buttonColor
      _buttonColor =
      _buttonColor == Colors.blue ? Colors.green : Colors.blue;
    });
  }

  // this is the build method which must be overridden in the state class of the stateful widget.
  // it describes the UI of the widget.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        print("ElevatedButton"),
        _toggleColor(),
      },
      style: ElevatedButton.styleFrom(backgroundColor: _buttonColor),
      child: Text("ColourChanging?"),
    );
  }
}
