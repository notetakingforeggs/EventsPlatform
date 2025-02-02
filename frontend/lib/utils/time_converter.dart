
import 'dart:ffi';

import 'package:intl/intl.dart';

class TimeConverter{

  int convertDateTimeStringToUnixTimecode(String date, String time){
    String dateTimeString = "$date $time";
    DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm");
    DateTime dateTime = dateFormat.parse(dateTimeString);
    DateTime utc = dateTime.toUtc();
    return utc.millisecondsSinceEpoch ~/ 1000;

    return 5;
  }
}