import 'dart:core';

import 'package:events_platform_frontend/data/models/app_event.dart';
import 'package:events_platform_frontend/core/services/api_service.dart';
import 'package:events_platform_frontend/data/providers/loading_provider.dart';
import 'package:flutter/cupertino.dart';

class EventListViewmodel extends ChangeNotifier {
  late Future<List<AppEvent>> futureEvents;

  final LoadingProvider loadingProvider;
  EventListViewmodel(this.loadingProvider);

  List<AppEvent> _eventList = [];

  // getter method
  List<AppEvent> get events => _eventList;

  // make call to get data from api
  void getEvents() async {
    loadingProvider.setLoading(true);
    notifyListeners();
    try {

      // todo doesnt make sense to be passing in the path here...
      _eventList = await ApiService().getData('api/v1/events');
      print("got event list: $_eventList, gonna notify listeneres");
      loadingProvider.setLoading(false);
      notifyListeners();
    } catch (e) {
      print("currently no events");
    }
  }

  Future<bool> attendEvent(int id)  async {
    return await ApiService().attendEvent(id);

  }
}
