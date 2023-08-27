part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEventLogin extends LoginEvent {
  final token;
  
  LoginEventLogin(this.token);
}
