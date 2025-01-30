import 'dart:convert';

import 'package:events_platform_frontend/pages/login_page.dart';
import 'package:events_platform_frontend/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;

import '../../models/AppUser.dart';
import '../custom_tabs/custom_tabs_1.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8080";

  // GET
  // future<void> is basically saying that the function will return voic ( we expect ) but it is async so it might not do it, or might not for a while?
  // can't (/shouldnt) use void return type for async functions
  Future<void> getData(String endpoint) async {
    final url = Uri.parse("$baseUrl/$endpoint");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("GET Response: ${response.body}");
      } else {
        print("GET Request error: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getDeepLink(String endpoint) async {
    final url = Uri.parse("$baseUrl/$endpoint");
    try {
      await http.get(url);
      // if (response.statusCode == 200) {
      //   print("got deep link: ${response.body}");
      // } else {
      //   print("issue getting deep link");
      // }
    } catch (e) {
      print(e);
      throw(e);
    }
  }

  Future<void> postUser(String googleIdToken, String googleAccessToken) async {
    User? user = AuthService().getCurrentUser();
    AppUser appUser = AppUser(
      firebaseUid: user!.uid,
      email: user.email,
      displayName: null,
      photoUrl: null,
      googleAccessToken: googleAccessToken,
      googleIdToken: googleIdToken,
    );

    Map<String, dynamic> check = appUser.toJson();
    String checkk = json.encode(check);
    print("check full json: ${checkk}");

    final response = await http.post(
        Uri.parse("$baseUrl/api/v1/auth/register-login"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(appUser.toJson()));

    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("response good: ${response.body}");
    } else {
      print("failed");
    }
  }

  Future<void> initBackendOAuthFlow(BuildContext context) async {
    final url = Uri.parse("$baseUrl/api/v1/auth/redirect-to-google");
    final response = await http.get(url);
    print("getting google rdr on backend");

    if(response.statusCode == 200) {

      print(response.body);
      CustomTabLauncher().launchGoogleAuthCustomTab(context, response.body);
    } else{
      print("fuckery");
    }
  }
}
