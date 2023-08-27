class Result {
  final int score;
  final List<bool> status;
  final List<ResultQuestion> questions;

  Result({
    required this.score,
    required this.status,
    required this.questions,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      score: json['score'],
      status: (json['status'] as List).cast<bool>(),
      questions: (json['questions'] as List)
          .map((questionJson) => ResultQuestion.fromJson(questionJson))
          .toList(),
    );
  }
}

class ResultQuestion {
  final String name;
  final String correctAnswer;
  final int score;

  ResultQuestion({
    required this.name,
    required this.correctAnswer,
    required this.score,
  });

  factory ResultQuestion.fromJson(Map<String, dynamic> json) {
    return ResultQuestion(
      name: json['name'],
      correctAnswer: json['correctAnswer'],
      score: json['score'],
    );
  }
}
