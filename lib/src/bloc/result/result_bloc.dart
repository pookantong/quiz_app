import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_fl/src/models/result.dart';
import 'package:test_fl/src/services/api_service.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(ResultInitial()) {
    on<LoadResult>(_loadResult);
  }

  Future<FutureOr<void>> _loadResult(
      LoadResult event, Emitter<ResultState> emit) async {
    emit(ResultLoadingState());
    final Result result = await ApiService().getResult(
      event.quizId,
      event.userAnswers,
    );
    emit(ResultSuccessfulState(result, event.quizId, event.userAnswers));
  }
}
