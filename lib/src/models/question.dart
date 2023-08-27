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
