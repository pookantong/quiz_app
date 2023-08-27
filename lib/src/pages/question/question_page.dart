import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/bloc/login/login_bloc.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/result/result_bloc.dart';
import 'package:test_fl/src/models/question.dart';
import 'package:test_fl/src/models/result.dart';
import 'package:test_fl/src/pages/routes.dart';
import 'package:test_fl/src/services/question_service.dart';
import 'package:test_fl/src/services/result_service.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Center(
                  child: Text(
                    state.name,
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                ...state.choices.map(
                  (answer) => ElevatedButton(
                    onPressed: () {
                      _handleAnswer(answer);
                    },
                    child: Text(answer),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleChangePage() async {
    final QuestionState questionState = context.read<QuestionBloc>().state;
    final LoginState loginState = context.read<LoginBloc>().state;
    final int quizId = questionState.quizId;
    final String token = loginState.token;
    final int page = questionState.page;
    final List<String> answers = questionState.answers;
    if (page == questionState.maxPage) {
      final Result result = await ResultService().getResult(
        quizId,
        answers,
        token,
      );
      context.read<ResultBloc>().add(LoadResult(result, answers));
      await Future.delayed(Duration(milliseconds: 100));
      Navigator.of(context).pushReplacementNamed(AppRoute.result);
    } else {
      final Question question = await QuestionService().getQuestion(
        quizId,
        page + 1,
        token,
      );
      context.read<QuestionBloc>().add(QuestionNextPage(
            question.choices,
            question.name,
            question.score,
            question.progress,
          ));
    }
  }

  Future<void> _handleAnswer(answer) async {
    context.read<QuestionBloc>().add(AnswerQuestion(answer));
    await Future.delayed(Duration(milliseconds: 100));
    _handleChangePage();
  }
}
