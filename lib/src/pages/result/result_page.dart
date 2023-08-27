import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/bloc/login/login_bloc.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/result/result_bloc.dart';
import 'package:test_fl/src/models/question.dart';
import 'package:test_fl/src/services/question_service.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
      ),
      body: BlocBuilder<ResultBloc, ResultState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Total Score: ${state.score}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Column(
                  children: List.generate(state.questions.length, (index) {
                    final question = state.questions[index];
                    final isCorrect = state.status[index];
                    final score = isCorrect ? question.score : 0;

                    return ListTile(
                      title: Text(question.name),
                      subtitle: Text(
                          'Your Answer: ${isCorrect ? "Correct" : "Incorrect"}'),
                      trailing: Text('Score: $score'),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _handleHome(context);
              },
              child: Text('Home'),
            ),
            ElevatedButton(
              onPressed: () {
                _handleRestart(context);
              },
              child: Text('restart'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRestart(BuildContext context) async {
    final LoginState loginState = context.read<LoginBloc>().state;
    final int quizId = context.read<QuestionBloc>().state.quizId;
    final Question question = await QuestionService().getQuestion(
      quizId,
      1,
      loginState.token,
    );
    context.read<QuestionBloc>().add(QuestionRestart(
          quizId,
          question.choices,
          question.name,
          question.score,
          question.maxPage,
        ));
  }

  void _handleHome(BuildContext context) {
    context.read<QuestionBloc>().add(ClearQuestion());
  }
}
