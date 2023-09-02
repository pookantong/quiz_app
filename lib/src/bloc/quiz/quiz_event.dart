part of 'quiz_bloc.dart';

sealed class QuizEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadQuizInitialEvent extends QuizEvent {
  final int page;
  
  LoadQuizInitialEvent(this.page);
}
