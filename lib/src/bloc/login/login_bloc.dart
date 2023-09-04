import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/pages/routes.dart';
import 'package:test_fl/src/services/api_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>(_loginInitialEvent);
    on<SignUpInitialEvent>(_signUpInitialEvent);
  }

  FutureOr<void> _loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final String token = await ApiService().login(
      event.username,
      event.password,
    );
    if (token != "") {
      await secureStorage.write(key: 'jwt', value: token);
      emit(LoginSuccessfulState());
      Navigator.pushReplacementNamed(
        navigatorState.currentContext!,
        AppRoute.home,
      );
    } else {
      emit(LoginErrorState());
    }
  }

  Future<FutureOr<void>> _signUpInitialEvent(
      SignUpInitialEvent event, Emitter<LoginState> emit) async {
    emit(SignUpLoadingState());
    final signUpStatus = await ApiService().signUp(
      event.username,
      event.email,
      event.password,
    );
    if (signUpStatus) {
      emit(SignUpSuccessfulState());
      Navigator.pop(
        navigatorState.currentContext!,
        AppRoute.home,
      );
    } else {
      emit(SignUpErrorState());
    }
  }
}
