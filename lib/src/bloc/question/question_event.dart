part of 'question_bloc.dart';

sealed class QuestionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class QuestionFirstLoadEvent extends QuestionEvent {
  final int quizId;

  QuestionFirstLoadEvent(this.quizId);
}

class QuestionNextPage extends QuestionEvent {
  final String answer;

  QuestionNextPage(this.answer);
}