import 'package:events_platform_frontend/utils/time_converter.dart';

class AppEvent {
  int? id;
  String? eventName;
  String? description;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;

  AppEvent(
    this.eventName,
    this.description,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
  );

  AppEvent.noArgs();

  AppEvent.fromJson(Map<String, dynamic> json) {
    // from json constructor - write this when it is clear the shape coming from the backend
    id=json['id'];
    eventName = json["eventName"];
    description = json["eventDescription"];
    startDate =
        TimeConverter().convertUnixTimeCodeToStrings(json["startDate"])["date"];
    startTime =
        TimeConverter().convertUnixTimeCodeToStrings(json["startDate"])["time"];
    endDate =
        TimeConverter().convertUnixTimeCodeToStrings(json["endDate"])["date"];
    endTime =
        TimeConverter().convertUnixTimeCodeToStrings(json["endDate"])["time"];
  }

  String? get name => eventName;
  // int? get id => id;

  @override
  String toString() {
    return 'AppEvent{eventName: $eventName, description: $description, startDate: $startDate, startTime: $startTime, endDate: $endDate, endTime: $endTime}';
  }

  Map<String, dynamic> toJson() {
    return {
      "eventName": eventName,
      "eventDescription": description,
      "startDate": TimeConverter()
          .convertDateTimeStringToUnixTimecode(startDate!, startTime!),
      "endDate": TimeConverter()
          .convertDateTimeStringToUnixTimecode(endDate!, endTime!),
    };
  }

  void updateField(String key, String value) {
    switch (key) {
      case 'event_name':
        eventName = value;
        break;
      case 'description':
        description = value;
        break;
      case 'start_date':
        startDate = value;
        break;
      case 'end_date':
        endDate = value;
        break;
      case 'start_time':
        startTime = value;
        break;
      case 'end_time':
        endTime = value;
        break;
      default:
        print('Unknown field: $key');
    }
  }
}
