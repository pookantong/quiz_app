import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/pages/routes.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc() : super(const QuestionState()) {
    on<QuestionLoad>((event, emit) {
      emit(state.copywith(
          choices: event.choices,
          name: event.name,
          score: event.score,
          quizId: event.quizId,
          maxPage: event.maxPage,
          page: 1,
          answers: []));
      Navigator.pushNamed(
        navigatorState.currentContext!,
        AppRoute.question,
      );
    });

    on<AnswerQuestion>((event, emit) {
      emit(state.copywith(answers: [...state.answers, event.answer]));
    });

    on<QuestionNextPage>((event, emit) {
      emit(state.copywith(
        choices: event.choices,
        name: event.name,
        score: event.score,
        page: state.page + 1,
        progress: event.progress,
      ));
    });

    on<ClearQuestion>((event, emit) {
      emit(state.copywith(
        choices: const [],
        name: "",
        score: 0,
        page: 1,
        progress: 0,
        maxPage: 0,
        quizId: 0,
        answers: const [],
      ));
      Navigator.pop(
        navigatorState.currentContext!,
      );
    });

    on<QuestionRestart>((event, emit) {
      emit(state.copywith(
          choices: event.choices,
          name: event.name,
          score: event.score,
          quizId: event.quizId,
          maxPage: event.maxPage,
          page: 1,
          answers: []));
      Navigator.pushReplacementNamed(
        navigatorState.currentContext!,
        AppRoute.question,
      );
    });
  }
}
