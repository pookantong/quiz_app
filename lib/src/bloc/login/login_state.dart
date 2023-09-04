part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {}

class LoginSuccessfulState extends LoginState {}

class SignUpLoadingState extends LoginState {}

class SignUpSuccessfulState extends LoginState {}

class SignUpErrorState extends LoginState {}
