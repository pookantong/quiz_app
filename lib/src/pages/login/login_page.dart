import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/bloc/login/login_bloc.dart';
import 'package:test_fl/src/bloc/quiz/quiz_bloc.dart';
import 'package:test_fl/src/models/quiz.dart';
import 'package:test_fl/src/pages/routes.dart';
import 'package:test_fl/src/services/home_service.dart';
import 'package:test_fl/src/services/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = "pookan1";
    _passwordController.text = "123456789";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Card(
              child: Container(
                height: 340,
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ..._buildTextFields(),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (!state.status && state.token == '')
                          // ignore: curly_braces_in_flow_control_structures
                          return Container(
                              height: 60,
                              padding: EdgeInsets.all(10),
                              child: const Text(
                                "เอ๋~ ลืมรหัสผ่านหรอ?\nรหัสผ่านยังลืมได้ แล้วทำไมถึงยังลืมเขาไม่ได้?",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 13),
                              ));
                        return const SizedBox(height: 40);
                      },
                    ),
                    ..._buildButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleClickLogin() async {
    final String token = await LoginService().login(
      _usernameController.text,
      _passwordController.text,
    );
    if (token != "") {
      final List<Quiz> quizzes = await HomeService().getQuiz(1, token);
      context.read<QuizBloc>().add(LoadQuiz(quizzes, 1));
    }
    context.read<LoginBloc>().add(LoginEventLogin(token));
  }

  void _handleClickRegister() {
    Navigator.pushNamed(context, AppRoute.register);
  }

  _buildButton() {
    return [
      ElevatedButton(
        onPressed: _handleClickLogin,
        child: Text("SignIn"),
      ),
      OutlinedButton(
        onPressed: _handleClickRegister,
        child: Text("Register"),
      )
    ];
  }

  _buildTextFields() {
    return [
      TextField(
        controller: _usernameController,
        decoration: InputDecoration(labelText: "Username"),
      ),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(labelText: "Password"),
      )
    ];
  }
}
