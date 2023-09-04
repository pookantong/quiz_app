import 'package:flutter/material.dart';
import 'package:test_fl/src/pages/create_quiz/create_quiz_page.dart';
import 'package:test_fl/src/pages/home/home_page.dart';
import 'package:test_fl/src/pages/login/login_page.dart';
import 'package:test_fl/src/pages/question/question_page.dart';
import 'package:test_fl/src/pages/register/register.dart';
import 'package:test_fl/src/pages/result/result_page.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';
  static const register = 'register';
  static const question = 'question';
  static const result = 'result';
  static const create = 'create';

  static get all => <String, WidgetBuilder>{
        login: (context) => const LoginPage(),
        home: (context) => const HomePage(),
        register: (context) => const RegisterPage(),
        question: (context) => const QuestionPage(),
        result: (context) => const ResultPage(),
        create: (context) => const QuizCreatePage(),
      };
}
