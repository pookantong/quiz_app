import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/bloc/login/login_bloc.dart';
import 'package:test_fl/src/pages/login/component/login_button.dart';
import 'package:test_fl/src/pages/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                height: 200,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 580,
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
                        "Sign Up",
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
                            const Text(
                              "Email",
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
                              controller: _emailController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                switch (state.runtimeType) {
                                  case SignUpLoadingState:
                                    return Container(
                                      height: 40,
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        "Loading...",
                                        style: TextStyle(
                                            fontFamily: 'Prompt',
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                    );
                                  case SignUpErrorState:
                                    return Container(
                                        height: 40,
                                        padding: const EdgeInsets.all(10),
                                        child: const Text(
                                          "username or email are already used",
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
                              onPressed: _handleClickRegister,
                              buttonText: 'Sign Up',
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                              child: Row(
                                children: [
                                  const Text("Already have an account?",
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontSize: 15,
                                        color: Color(0xFF8d8d8d),
                                      )),
                                  TextButton(
                                    onPressed: _handleClickBackLogin,
                                    child: const Text(
                                      "Login",
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

  Future<void> _handleClickRegister() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    context.read<LoginBloc>().add(SignUpInitialEvent(
          email,
          username,
          password,
        ));
  }

  _buildButton() {
    return [
      ElevatedButton(
        onPressed: _handleClickRegister,
        child: Text("Register"),
      ),
    ];
  }

  _buildTextFields() {
    return [
      TextField(
        controller: _usernameController,
        decoration: InputDecoration(labelText: "Username"),
      ),
      TextField(
        controller: _emailController,
        decoration: InputDecoration(labelText: "Email"),
      ),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(labelText: "Password"),
      )
    ];
  }

  void _handleClickBackLogin() {
    Navigator.pop(
      navigatorState.currentContext!,
      AppRoute.login,
    );
  }
}
