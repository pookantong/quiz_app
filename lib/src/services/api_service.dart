import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/models/question.dart';
import 'package:test_fl/src/models/quiz.dart';
import 'package:test_fl/src/models/result.dart';

class ApiService {
  static const _baseUrl = "http://10.0.2.2:8000";

  Future<List<Quiz>> getQuiz(int page) async {
    final token = await secureStorage.read(key: 'jwt');
    final response = await http.get(
      Uri.parse("$_baseUrl/quiz?page=$page&take=9"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
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

  Future<Question> getQuestion(int quizId, int page) async {
    final token = await secureStorage.read(key: 'jwt');
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

  Future<Result> getResult(int quizId, List<String> answers) async {
    final token = await secureStorage.read(key: 'jwt');
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

  Future<bool> signUp(String username, String email, String password) async {
    final body = {
      'username': username,
      'email': email,
      'password': password,
    };

    final response =
        await http.post(Uri.parse("$_baseUrl/auth/signup"), body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to fetch result');
    }
  }
}
