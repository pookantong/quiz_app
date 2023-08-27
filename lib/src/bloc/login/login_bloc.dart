import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/pages/routes.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEventLogin>((event, emit) {
      if (event.token != '') {
        emit(state.copywith(token: event.token, status: true));
        if (navigatorState.currentContext != null) {
          Navigator.pushReplacementNamed(
            navigatorState.currentContext!,
            AppRoute.home,
          );
        }
      } else {
        emit(state.copywith(status: false));
      }
    });
  }
}
