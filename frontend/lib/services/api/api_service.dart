import 'dart:convert';

import 'package:events_platform_frontend/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;

import '../../models/AppUser.dart';

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


  Future<void> postUser(String token) async {

    User? user = AuthService().getCurrentUser();
    AppUser appUser = AppUser(
        firebaseUid: user!.uid,
        email: user.email,
        googleToken: token);
    final response = await http.post(
        Uri.parse("$baseUrl/api/v1/auth/register-login"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(appUser.toJson()));
    if(response.statusCode == 200 || response.statusCode == 201) {
      print("response good: ${response.body}");
    }else {
      print("failed");
    }
  }
}
