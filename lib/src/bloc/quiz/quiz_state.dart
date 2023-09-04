part of 'quiz_bloc.dart';

sealed class QuizState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadQuizInitial extends QuizState {}

class LoadQuizLoadingState extends QuizState {}

class LoadQuizSuccessfulState extends QuizState {
  final List<Quiz> quizzes;
  final int page;
  final int maxPage;

  LoadQuizSuccessfulState({
    required this.quizzes,
    required this.page,
    required this.maxPage,
  });
}
