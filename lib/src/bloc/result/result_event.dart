part of 'result_bloc.dart';

sealed class ResultEvent extends Equatable {
  const ResultEvent();

  @override
  List<Object> get props => [];
}

class LoadResult extends ResultEvent {
  final Result result;
  final List<String> userAnswers;

  LoadResult(this.result, this.userAnswers);
}
