import 'package:events_platform_frontend/utils/time_converter.dart';

class AppEvent {
  final String eventName;
  final String description;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;

  AppEvent(
      this.eventName,
      this.description,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      );

  @override
  String toString() {
    return 'AppEvent{eventName: $eventName, description: $description, startDate: $startDate, startTime: $startTime, endDate: $endDate, endTime: $endTime}';
  }
  Map<String, dynamic> toJson() {
    return {
      "event_name": eventName,
      "description": description,
      "start_timestamp": TimeConverter().convertDateTimeStringToUnixTimecode(startDate, startTime),
      "end_timestamp": TimeConverter().convertDateTimeStringToUnixTimecode(endDate, endTime),
    };
}

// {event_name: party, description: deets, start_date: 17/02/2025, start_time: 19:00, end_date: 17/02/2025, end_time: 20:00}
