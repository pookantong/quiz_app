import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/bloc/login/login_bloc.dart';
import 'package:test_fl/src/bloc/quiz/quiz_bloc.dart';
import 'package:test_fl/src/pages/login/component/login_button.dart';
import 'package:test_fl/src/pages/routes.dart';

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
    _usernameController.text = "pookan";
    _passwordController.text = "123456789";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfed8c3),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/quiz-logo.png',
                width: double.infinity,
                height: 300,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 505,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Log In",
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4f4f4f),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ..._buildTextFields(),
                            BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state.runtimeType == LoginSuccessfulState) {
                                  context
                                      .read<QuizBloc>()
                                      .add(LoadQuizInitialEvent(1));
                                }
                              },
                              builder: (context, state) {
                                switch (state.runtimeType) {
                                  case LoginLoadingState:
                                    return Container(
                                      height: 45,
                                      padding: EdgeInsets.all(10),
                                      child: const Text(
                                        "Loading...",
                                        style: TextStyle(
                                            fontFamily: 'Prompt',
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                    );
                                  case LoginErrorState:
                                    return Container(
                                        height: 60,
                                        padding: EdgeInsets.all(10),
                                        child: const Text(
                                          "เอ๋~ ลืมรหัสผ่านหรอ?\nรหัสผ่านยังลืมได้ แล้วทำไมถึงยังลืมเขาไม่ได้?",
                                          style: TextStyle(
                                            fontFamily: 'Prompt',
                                            color: Colors.red,
                                            fontSize: 13,
                                          ),
                                        ));
                                  default:
                                    return const SizedBox(
                                      height: 20,
                                    );
                                }
                              },
                            ),
                            LoginButton(
                              onPressed: _handleClickLogin,
                              buttonText: 'Login',
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                              child: Row(
                                children: [
                                  const Text("Don't have an account?",
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontSize: 15,
                                        color: Color(0xFF8d8d8d),
                                      )),
                                  TextButton(
                                    onPressed: _handleClickRegister,
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontSize: 15,
                                        color: Color(0xFF44564a),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleClickLogin() async {
    context.read<LoginBloc>().add(LoginInitialEvent(
          _usernameController.text,
          _passwordController.text,
        ));
  }

  void _handleClickRegister() {
    Navigator.pushNamed(context, AppRoute.register);
  }

  _buildTextFields() {
    return [
      const Text(
        "Username",
        style: TextStyle(
          fontFamily: 'Prompt',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8d8d8d),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      TextField(
        controller: _usernameController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
        ),
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Password",
        style: TextStyle(
          fontFamily: 'Prompt',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8d8d8d),
        ),
      ),
      TextField(
        controller: _passwordController,
        obscureText: false,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
        ),
      ),
    ];
  }
}
