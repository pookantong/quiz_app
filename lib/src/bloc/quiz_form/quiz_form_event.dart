part of 'quiz_form_bloc.dart';

sealed class QuizFormEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class SubmitQuizEvent extends QuizFormEvent {
  final QuizFormModel quizFormModel;

  SubmitQuizEvent(this.quizFormModel);
}
