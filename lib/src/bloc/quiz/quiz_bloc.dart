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
  }

  Future<FutureOr<void>> _loadQuizInitialEvent(
      LoadQuizInitialEvent event, Emitter<QuizState> emit) async {
    emit(LoadQuizLoadingState());
    final List<Quiz> quizzes = await ApiService().getQuiz(event.page);
    emit(LoadQuizSuccessfulState(
      quizzes: quizzes,
      page: event.page,
    ));
  }
}
