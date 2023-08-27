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
