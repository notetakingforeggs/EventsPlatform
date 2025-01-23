import 'dart:convert';

import 'package:http/http.dart' as http;

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

  // POST access token to backend
  // unsure about the headers?
  Future<void> sendAccessTokenToBackend(String? token) async {
    if (token != null) {
      final response = await http.post(
          Uri.parse("$baseUrl/api/v1/auth/store-google-token"),
          headers: {'Authorization': 'Bearer $token'},
          body: jsonEncode({'token': token}));
      (response.statusCode == 200)
          ? print("token submission gets a 200")
          : print("issue with token posting");
    }
  }
}
