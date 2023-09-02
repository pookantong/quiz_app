import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/result/result_bloc.dart';
import 'package:test_fl/src/pages/routes.dart';

class ResultPage extends StatefulWidget {
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
      ),
      body: BlocBuilder<ResultBloc, ResultState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ResultSuccessfulState:
              final successState = state as ResultSuccessfulState;
              final result = successState.result;

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total Score: ${result.score}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: List.generate(result.questions.length, (index) {
                        final question = result.questions[index];
                        final isCorrect = result.status[index];
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
            default:
              return SizedBox(
                child: Text('data'),
              );
          }
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
    final ResultState resultState = context.read<ResultBloc>().state;
    final resultSuccessfulState = resultState as ResultSuccessfulState;
    Navigator.pop(context);
    context
        .read<QuestionBloc>()
        .add(QuestionFirstLoadEvent(resultSuccessfulState.quizId));
  }

  void _handleHome(BuildContext context) {
    Navigator.pop(
      navigatorState.currentContext!,
      AppRoute.home,
    );
  }
}
