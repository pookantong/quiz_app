part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitialEvent extends LoginEvent {
  final String username;
  final String password;

  LoginInitialEvent(
    this.username,
    this.password,
  );
}

class SignUpInitialEvent extends LoginEvent {
  final String email;
  final String username;
  final String password;

  SignUpInitialEvent(
    this.email,
    this.username,
    this.password,
  );
}
