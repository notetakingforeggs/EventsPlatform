import 'package:events_platform_frontend/presentation/pages/add_event/add_event_page.dart';
import 'package:events_platform_frontend/presentation/pages/home/playground.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../event_list_page/event_list_page.dart';

class HomeViewModel extends ChangeNotifier{
  int _currentIndex = 0;

  final List<Widget> _homeScreens = [
    Playground(),
    EventListPage(),
    AddEventPage(),
  ];

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  List<Widget> get homeScreens => _homeScreens;


}