part of 'result_bloc.dart';

sealed class ResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadResult extends ResultEvent {
  final List<String> userAnswers;
  final int quizId;

  LoadResult(this.quizId, this.userAnswers);
}
