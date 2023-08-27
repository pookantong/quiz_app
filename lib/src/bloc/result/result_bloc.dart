import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_fl/src/models/result.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(ResultInitial()) {
    on<LoadResult>((event, emit) {
      emit(state.copyWith(
        questions: event.result.questions,
        score: event.result.score,
        status: event.result.status,
        userAnswers: event.userAnswers,
      ));
    });
  }
}
