import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_fl/src/models/question.dart';

class QuestionService {
  static const _baseUrl = "http://10.0.2.2:8000";

  Future<Question> getQuestion(int quizId, int page, String token) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/question/$quizId?page=$page"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      Map<String, dynamic> questionJson = responseJson['question'];
      return Question.fromJson(questionJson);
    } else {
      throw Exception('error');
    }
  }
}
