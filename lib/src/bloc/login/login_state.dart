part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String token;
  final bool status;

  const LoginState({
    this.token = "",
    this.status = true
  });

  LoginState copywith({
    String? token,
    bool? status,
  }) {
    return LoginState(
      token: token ?? this.token,
      status: status ?? this.status
    );
  }

  @override
  List<Object?> get props => [token];
}
