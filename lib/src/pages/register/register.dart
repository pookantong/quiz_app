import 'package:flutter/material.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/pages/routes.dart';
import 'package:test_fl/src/services/api_service.dart';

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
      backgroundColor: Colors.grey[600],
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Card(
              child: Container(
                height: 400,
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ..._buildTextFields(),
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

  Future<void> _handleClickRegister() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    final signUpStatus = await ApiService().signUp(username, email, password);
    if (signUpStatus) {
      Navigator.pop(
        navigatorState.currentContext!,
        AppRoute.home,
      );
    }
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
}
