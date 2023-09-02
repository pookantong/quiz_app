part of 'question_bloc.dart';

sealed class QuestionState extends Equatable {
  @override
  List<Object> get props => [];
}

class QuestionInitial extends QuestionState {}

class LoadQuestionLoadingState extends QuestionState {}

class LoadQuestionSuccessfulState extends QuestionState {
  final Question question;
  final int quizId;
  final List<String> answers;
  final int page;

  LoadQuestionSuccessfulState(
    this.question,
    this.quizId,
    this.answers,
    this.page,
  );
}

class ResultQuestionState extends QuestionState {
  final int quizId;
  final List<String> answers;

  ResultQuestionState(this.quizId, this.answers);
}
