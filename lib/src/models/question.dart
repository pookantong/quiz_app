class Question {
  final String name;
  final int score;
  final List<String> choices;
  final int progress;
  final int maxPage;

  Question(
      {required this.name,
      required this.score,
      required this.choices,
      required this.progress,
      required this.maxPage});

  factory Question.fromJson(Map<dynamic, dynamic> json) {
    return Question(
      name: json['name'],
      score: json['score'],
      choices: List<String>.from(json['choices']),
      progress: json['progress'],
      maxPage: json['maxPage'],
    );
  }
}

class QuestionFormModel {
  String name;
  List<String> choices;
  String correctAnswer;
  int score;

  QuestionFormModel({
    required this.name,
    required this.choices,
    required this.correctAnswer,
    required this.score,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'choices': choices,
      'correctAnswer': correctAnswer,
      'score': score,
    };
  }
}
