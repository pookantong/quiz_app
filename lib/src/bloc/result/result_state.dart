part of 'result_bloc.dart';

sealed class ResultState extends Equatable {
  @override
  List<Object> get props => [];
}

class ResultInitial extends ResultState {}

class ResultLoadingState extends ResultState {}

class ResultSuccessfulState extends ResultState {
  final Result result;
  final int quizId;
  final List<String> userAnswers;
  ResultSuccessfulState(
    this.result,
    this.quizId,
    this.userAnswers,
  );
}
