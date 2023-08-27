part of 'question_bloc.dart';

class QuestionState extends Equatable {
  final int quizId;
  final List<String> choices;
  final String name;
  final int score;
  final int progress;
  final int page;
  final List<String> answers;
  final int maxPage;

  const QuestionState(
      {this.quizId = 0,
      this.choices = const [],
      this.name = "",
      this.score = 0,
      this.progress = 0,
      this.page = 1,
      this.answers = const [],
      this.maxPage = 0});

  QuestionState copywith({
    int? quizId,
    List<String>? choices,
    String? name,
    int? score,
    int? progress,
    int? page,
    List<String>? answers,
    int? maxPage,
  }) {
    return QuestionState(
      quizId: quizId ?? this.quizId,
      choices: choices ?? this.choices,
      name: name ?? this.name,
      score: score ?? this.score,
      progress: progress ?? this.progress,
      page: page ?? this.page,
      answers: answers ?? this.answers,
      maxPage: maxPage ?? this.maxPage,
    );
  }

  @override
  List<Object> get props => [
        choices,
        name,
        score,
        progress,
        page,
        quizId,
        answers,
        maxPage,
      ];
}
