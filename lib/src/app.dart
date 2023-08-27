import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/bloc/login/login_bloc.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/quiz/quiz_bloc.dart';
import 'package:test_fl/src/bloc/result/result_bloc.dart';
import 'package:test_fl/src/pages/login/login_page.dart';
import 'package:test_fl/src/pages/routes.dart';

final navigatorState = GlobalKey<NavigatorState>();

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider(create: (context) => LoginBloc());
    final quizBloc = BlocProvider(create: (context) => QuizBloc());
    final questionBloc = BlocProvider(create: (context) => QuestionBloc());
    final resultBloc = BlocProvider(create: (context) => ResultBloc());

    return MultiBlocProvider(
      providers: [loginBloc, quizBloc, questionBloc, resultBloc],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "QuizApp",
        routes: AppRoute.all,
        home: const LoginPage(),
        navigatorKey: navigatorState,
      ),
    );
  }
}
