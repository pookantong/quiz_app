import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/bloc/login/login_bloc.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/quiz/quiz_bloc.dart';
import 'package:test_fl/src/models/question.dart';
import 'package:test_fl/src/services/question_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = state.quizzes[index];
                  return Card(
                    child: ElevatedButton(
                      onPressed: () => {
                        _handleClickQuiz(context, quiz.quizId),
                      },
                      child: Text(quiz.name),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _handleClickQuiz(BuildContext context, int quizId) async {
    final LoginState loginState = context.read<LoginBloc>().state;
    final Question question = await QuestionService().getQuestion(
      quizId,
      1,
      loginState.token,
    );
    context.read<QuestionBloc>().add(QuestionLoad(
          quizId,
          question.choices,
          question.name,
          question.score,
          question.maxPage,
        ));
  }
}
