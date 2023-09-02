part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitialEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginInitialEvent(
    this.username,
    this.password,
  );
}
