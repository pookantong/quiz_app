import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_fl/src/models/quiz.dart';

class HomeService {
  static const _baseUrl = "http://10.0.2.2:8000";

  Future<List<Quiz>> getQuiz(int page, String token) async {

    final response = await http.get(
      Uri.parse("$_baseUrl/quiz?page=$page&take=9"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = await json.decode(response.body);
      final List quizzes = responseJson['quizzes'];
      return quizzes.map((m) => Quiz.fromJson(m)).toList();
    } else {
      throw Exception('Failed to fetch quizzes');
    }
  }
}
