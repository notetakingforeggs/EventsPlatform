import 'package:flutter/cupertino.dart';

class AddEventController {

String? nameValidator(value){
  if (value == null || value.isEmpty) {
    return 'please enter some text';
  }
  return null;
}
// validation methods:
}