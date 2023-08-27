part of 'question_bloc.dart';

@immutable
sealed class QuestionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class QuestionLoad extends QuestionEvent {
  final int quizId;
  final List<String> choices;
  final String name;
  final int score;
  final int maxPage;

  QuestionLoad(
    this.quizId,
    this.choices,
    this.name,
    this.score,
    this.maxPage,
  );
}

class AnswerQuestion extends QuestionEvent {
  final String answer;

  AnswerQuestion(this.answer);
}

class QuestionNextPage extends QuestionEvent {
  final List<String> choices;
  final String name;
  final int score;
  final int progress;

  QuestionNextPage(
    this.choices,
    this.name,
    this.score,
    this.progress,
  );
}

class ClearQuestion extends QuestionEvent {}

class QuestionRestart extends QuestionEvent {
  final int quizId;
  final List<String> choices;
  final String name;
  final int score;
  final int maxPage;

  QuestionRestart(
    this.quizId,
    this.choices,
    this.name,
    this.score,
    this.maxPage,
  );
}
