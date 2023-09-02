import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/models/question.dart';
import 'package:test_fl/src/pages/routes.dart';
import 'package:test_fl/src/services/api_service.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc() : super(QuestionInitial()) {
    on<QuestionFirstLoadEvent>(_loadFirstQuestionEvent);
    on<QuestionNextPage>(_loadQuestionNextPage);
  }

  FutureOr<void> _loadFirstQuestionEvent(
      QuestionFirstLoadEvent event, Emitter<QuestionState> emit) async {
    Navigator.pushNamed(
      navigatorState.currentContext!,
      AppRoute.question,
    );
    emit(LoadQuestionLoadingState());
    final Question question = await ApiService().getQuestion(event.quizId, 1);
    emit(LoadQuestionSuccessfulState(question, event.quizId, [], 1));
  }

  Future<void> _loadQuestionNextPage(
      QuestionNextPage event, Emitter<QuestionState> emit) async {
    final currentState = state;
    if (currentState is LoadQuestionSuccessfulState) {
      emit(LoadQuestionLoadingState());
      final int nextPage = currentState.page + 1;
      final int quizId = currentState.quizId;
      final List<String> answers = [...currentState.answers, event.answer];
      if (nextPage > currentState.question.maxPage) {
        emit(ResultQuestionState(quizId, answers));
        Navigator.pushReplacementNamed(
          navigatorState.currentContext!,
          AppRoute.result,
        );
      } else {
        final Question question =
            await ApiService().getQuestion(quizId, nextPage);
        emit(LoadQuestionSuccessfulState(
          question,
          quizId,
          answers,
          nextPage,
        ));
      }
    }
  }
}
