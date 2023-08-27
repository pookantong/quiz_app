part of 'quiz_bloc.dart';

@immutable
sealed class QuizEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadQuiz extends QuizEvent {
  final List<Quiz> quizzes;
  final int page;

  LoadQuiz(this.quizzes, this.page);
}
