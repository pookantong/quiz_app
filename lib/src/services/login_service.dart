import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const _baseUrl = "http://10.0.2.2:8000";

  Future<String> login(String username, String password) async {
    final body = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      Uri.parse("$_baseUrl/auth/login"),
      body: body,
    );
    if (response.statusCode == 201) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      return responseJson['token'];
    } else {
      return "";
    }
  }
}
