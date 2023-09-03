part of 'quiz_form_bloc.dart';

sealed class QuizFormState extends Equatable {

  @override
  List<Object> get props => [];
}

final class QuizFormInitial extends QuizFormState {}

final class QuizFormSuccessFulState extends QuizFormState {
  final QuizFormModel quizFormModel;

  QuizFormSuccessFulState(this.quizFormModel);
}

final class QuizFormLoadingState extends QuizFormState {}
