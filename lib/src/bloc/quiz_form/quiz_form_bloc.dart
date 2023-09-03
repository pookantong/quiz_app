import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/models/quiz.dart';
import 'package:test_fl/src/pages/routes.dart';
import 'package:test_fl/src/services/api_service.dart';

part 'quiz_form_event.dart';
part 'quiz_form_state.dart';

class QuizFormBloc extends Bloc<QuizFormEvent, QuizFormState> {
  QuizFormBloc() : super(QuizFormInitial()) {
    on<SubmitQuizEvent>(_submitQuizEvent);
  }

  Future<FutureOr<void>> _submitQuizEvent(
      SubmitQuizEvent event, Emitter<QuizFormState> emit) async {
    emit(QuizFormLoadingState());
    final createStatus = await ApiService().createQuiz(event.quizFormModel);
    if (createStatus) {
      Navigator.pop(
        navigatorState.currentContext!,
        AppRoute.login,
      );
    }
  }
}
