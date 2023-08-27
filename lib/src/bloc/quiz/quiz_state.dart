part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final List<Quiz> quizzes;
  final int page;
  final List<String> answers;

  const QuizState({
    this.quizzes = const [],
    this.page = 1,
    this.answers = const [],
  });

  QuizState copyWith({
    List<Quiz>? quizzes,
    int? page,
    List<String>? answers
  }) {
    return QuizState(
      quizzes: quizzes ?? this.quizzes,
      page: page ?? this.page,
      answers: answers ?? this.answers,
    );
  }

  @override
  List<Object?> get props => [quizzes, page, answers];
}
