import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_fl/src/models/quiz.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(const QuizState()) {
    on<LoadQuiz>((event, emit) {
      emit(state.copyWith(
        page: 1,
        quizzes: event.quizzes,
      ));
    });
  }
}
