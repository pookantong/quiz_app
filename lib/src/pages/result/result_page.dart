import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/quiz/quiz_bloc.dart';
import 'package:test_fl/src/bloc/result/result_bloc.dart';
import 'package:test_fl/src/pages/routes.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfed8c3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<ResultBloc, ResultState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case ResultSuccessfulState:
                  final successState = state as ResultSuccessfulState;
                  final result = successState.result;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        'Total Score: ${result.score}',
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Prompt",
                        ),
                      ),
                      const SizedBox(height: 35),
                      Column(
                        children:
                            List.generate(result.questions.length, (index) {
                          final question = result.questions[index];
                          final isCorrect = result.status[index];
                          final userAnswer = successState.userAnswers[index];
                          final score = isCorrect ? question.score : 0;
                          final borderColor = isCorrect
                              ? Color.fromARGB(255, 122, 212, 125)
                              : Colors.red;

                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 10,
                            ),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: borderColor,
                                width: 5.0,
                              ),
                            ),
                            child: ListTile(
                              title: Text("${index + 1}. ${question.name}"),
                              subtitle: Text('Your Answer: $userAnswer'),
                              trailing: Text('Score: $score'),
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                default:
                  return const Center(
                    child: SizedBox(
                      child: Text('Loading...'),
                    ),
                  );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                _handleHome(context);
              },
              child: Icon(
                Icons.home,
                size: 40,
                color: HexColor('#44564a'),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                _handleRestart(context);
              },
              child: Icon(
                Icons.restart_alt,
                size: 40,
                color: HexColor('#44564a'),
              ),
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
    context.read<QuizBloc>().add(LoadQuizInitialEvent(1));
    Navigator.pop(
      navigatorState.currentContext!,
      AppRoute.home,
    );
  }
}
