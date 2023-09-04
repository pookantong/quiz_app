import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_fl/src/models/quiz.dart';
import 'package:test_fl/src/services/api_service.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(LoadQuizInitial()) {
    on<LoadQuizInitialEvent>(_loadQuizInitialEvent);
    on<IncreasePageEvent>(_increasePageEvent);
    on<DecreasePageEvent>(_decreasePageEvent);
  }

  Future<FutureOr<void>> _loadQuizInitialEvent(
      LoadQuizInitialEvent event, Emitter<QuizState> emit) async {
    emit(LoadQuizLoadingState());
    final QuizJsonMaxPage quizJsonMaxPage =
        await ApiService().getQuiz(event.page);
    emit(LoadQuizSuccessfulState(
        quizzes: quizJsonMaxPage.quizzes,
        page: event.page,
        maxPage: quizJsonMaxPage.maxPage));
  }

  FutureOr<void> _increasePageEvent(
      IncreasePageEvent event, Emitter<QuizState> emit) {
    final currentState = state;
    if (currentState is LoadQuizSuccessfulState) {
      final nextPage = currentState.page + 1;
      if (nextPage <= currentState.maxPage) {
        add(LoadQuizInitialEvent(nextPage));
      }
    }
  }

  FutureOr<void> _decreasePageEvent(
      DecreasePageEvent event, Emitter<QuizState> emit) {
    final currentState = state;
    if (currentState is LoadQuizSuccessfulState) {
      final prevPage = currentState.page - 1;
      if (prevPage > 0) {
        add(LoadQuizInitialEvent(prevPage));
      }
    }
  }
}
