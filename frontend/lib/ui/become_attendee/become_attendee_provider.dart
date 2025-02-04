import 'dart:core';

import 'package:events_platform_frontend/models/app_event.dart';
import 'package:events_platform_frontend/services/api/api_service.dart';
import 'package:flutter/cupertino.dart';

class BecomeAttendeeProvider extends ChangeNotifier {
  late Future<List<AppEvent>> futureEvents;

  List<AppEvent> _eventList= [];

  // getter method
  List<AppEvent> get events => _eventList;

  // make call to get data from api
  void getEvents() async {
    try {
      // todo doesnt make sense to be passing in the path here...
      _eventList = await ApiService().getData('api/v1/events');
      print("got event list: $_eventList, gonna notify listeneres");
      notifyListeners();
    }catch(e){
      print("currently no events");
    }
  }

  bool attendEvent(int id){

    try{
      response = await ApiService().attendEvent(id);
      if(response.status() == 200){
        return true;
      }
      return false;
    }
    catch(e){
      print('maybe catch null errors in here rather than passing them to the ui');
      rethrow;
    }

  }


}
