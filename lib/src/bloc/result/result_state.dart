part of 'result_bloc.dart';

class ResultState extends Equatable {
  final List<ResultQuestion> questions;
  final List<bool> status;
  final int score;
  final List<String> userAnswers;

  const ResultState({
    this.questions = const [],
    this.score = 0,
    this.status = const [],
    this.userAnswers = const []
  });

  ResultState copyWith({
    final List<ResultQuestion>? questions,
    final List<bool>? status,
    final int? score,
    final List<String>? userAnswers,
  }) {
    return ResultState(
      questions: questions ?? this.questions,
      status: status ?? this.status,
      score: score ?? this.score,
      userAnswers: userAnswers ?? this.userAnswers,
    );
  }

  @override
  List<Object> get props => [questions, score, status, userAnswers];
}

final class ResultInitial extends ResultState {}
