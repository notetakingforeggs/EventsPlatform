import 'dart:convert';

import 'package:events_platform_frontend/data/models/app_event.dart';
import 'package:events_platform_frontend/presentation/pages/login/login_page.dart';
import 'package:events_platform_frontend/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;


class ApiService {
  final String baseUrl = "http://10.0.2.2:8080";

  // GET event data from backend
  // future<void> is basically saying that the function will return voic ( we expect ) but it is async so it might not do it, or might not for a while?
  // can't (/shouldnt) use void return type for async functions

  Future<List<AppEvent>> getData(String endpoint) async {
    final url = Uri.parse("$baseUrl/$endpoint");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("GET Response: ${response.body}");
        List<dynamic> eventsAsJsonObjs = jsonDecode(response.body);
        print(eventsAsJsonObjs);
        // This bit is fucking up
        List<AppEvent> eventList = eventsAsJsonObjs.map((event)=> AppEvent.fromJson(event)).toList();
        print("returning eventlist: $eventList");
        return eventList;
      } else {
        print("GET Request error: ${response.statusCode}");
        throw Exception("get request failed");
      }
    } catch (e) {
      //TODO Do something better here. global exception handler?
      print(e);
      rethrow;
    }
  }

Future<void> addEvent(AppEvent formData) async{
    Map<String, dynamic> formDataMap = formData.toJson();
    String jsonFormData = jsonEncode(formDataMap);


    final response = await http.post(
      Uri.parse("$baseUrl/api/v1/events/add-event"),
      headers: {"Content-Type": "application/json"},
      body:jsonFormData);
    // TODO use this to do something different in the presentation, like a different toast or smth. I think do this in the parent widget.
    if(response.statusCode == 200){
      print("hunky dory");
    }else{
      print("issue with adding the event to the backend");
    }

}
// TODO here pass in pathparams from event click? get google id from token and event id from event click. put most of the logic in here and just call this from the provider?
  Future<bool> attendEvent(int eventId)async{
  String googleUserId = await AuthService().getGoogleId();

    final response = await http.post(Uri.parse('$baseUrl/api/v1/events/attend-event/$eventId/attendees/$googleUserId'));
    if(response.statusCode == 200 || response.statusCode == 201){
      return true;
    }
  (response.statusCode == 500)? print('500 internal server error'): print("idk wtf is going on");
    return false;
}

  // // TODO  why would i need to post user? remove this? I guess maybe if i allow editin profile at some point?
  // Future<void> postUser(String googleIdToken, String googleAccessToken) async {
  //   User? user = AuthService().getCurrentUser();
  //   AppUser appUser = AppUser(
  //     firebaseUid: user!.uid,
  //     email: user.email,
  //     displayName: null,
  //     photoUrl: null,
  //     googleAccessToken: googleAccessToken,
  //     googleIdToken: googleIdToken,
  //   );
  //
  //   Map<String, dynamic> check = appUser.toJson();
  //   String checkk = json.encode(check);
  //   print("check full json: ${checkk}");
  //
  //   final response = await http.post(
  //       Uri.parse("$baseUrl/api/v1/auth/register-login"),
  //       headers: {"Content-Type": "application/json"},
  //       body: json.encode(appUser.toJson()));
  //
  //   print(response.body);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print("response good: ${response.body}");
  //   } else {
  //     print("failed");
  //   }
  // }


}
