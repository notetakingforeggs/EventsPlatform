import 'package:http/http.dart' as http;

class ApiService {

  final String baseUrl = "http://10.0.2.2:8080";

  // GET
  Future<void> getData(String endpoint) async {
      final url = Uri.parse("$baseUrl/$endpoint");
      try{
        final response = await http.get(url);
        if(response.statusCode == 200){
          print("GET Response: ${response.body}");
        }else{
          print("GET Request error: ${response.statusCode}");
        }
      }catch (e){
        print(e);
      }
  }

}
