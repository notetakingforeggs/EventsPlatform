import 'package:events_platform_frontend/core/services/api_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/app_event.dart';

class AddEventViewmodel {

  // a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  // initialise with all fields null ( i think)
  AppEvent formData = new AppEvent.noArgs();


  GlobalKey<FormState> getFormKey(){
    return _formKey;
  }

  void saveData(String key, value){
    print('saving data');
    print(key);
    print(value);
    formData.updateField(key, value);
  }

  void submitForm(){
    print('submitting form');


      print('0000000000000000000000000000000000000000000000000000000');
      print("submitting form data: $formData");

      //todo call api service
      ApiService().addEvent(formData);

  }

  String? nameValidator(value){
  if (value == null || value.isEmpty) {
    return 'please enter some text';
  }
  return null;
}
// validation methods:
}