import 'package:test_fl/src/models/question.dart';

class QuizJsonMaxPage {
  final int maxPage;
  final List<Quiz> quizzes;

  QuizJsonMaxPage({
    required this.maxPage,
    required this.quizzes,
  });
}

class Quiz {
  final int quizId;
  final String name;
  final int score;
  final bool completed;

  Quiz({
    required this.quizId,
    required this.name,
    required this.score,
    required this.completed,
  });

  factory Quiz.fromJson(Map<dynamic, dynamic> json) {
    return Quiz(
      quizId: json['quizId'],
      name: json['name'],
      score: json['score'],
      completed: json['completed'],
    );
  }
}

class QuizFormModel {
  String name;
  int score;
  List<QuestionFormModel> questions;

  QuizFormModel({
    required this.name,
    required this.score,
    required this.questions,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}
