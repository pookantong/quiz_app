import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_fl/src/models/result.dart';

class ResultService {
  static const _baseUrl = "http://10.0.2.2:8000";

  Future<Result> getResult(
      int quizId, List<String> answers, String token) async {
    final body = json.encode({'answers': answers}); // Encode the entire map
    final response = await http.post(
      Uri.parse("$_baseUrl/quiz/$quizId"),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 201) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      return Result.fromJson(responseJson);
    } else {
      throw Exception('Failed to fetch result');
    }
  }
}
