import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/result/result_bloc.dart';
import 'package:test_fl/src/pages/question/component/choice_button.dart';
import 'package:test_fl/src/pages/question/component/progress_bar.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfed8c3),
      body: SafeArea(
        child: BlocConsumer<QuestionBloc, QuestionState>(
          listener: (context, state) {
            if (state.runtimeType == ResultQuestionState) {
              final resultState = state as ResultQuestionState;
              context.read<ResultBloc>().add(LoadResult(
                    resultState.quizId,
                    resultState.answers,
                  ));
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadQuestionSuccessfulState:
                final successState = state as LoadQuestionSuccessfulState;
                final question = successState.question;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ProgressBar(progress: question.progress),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: 25,
                          top: 25,
                        ),
                        child: Text(
                          'Question ${successState.page}/${successState.question.maxPage}',
                          style: const TextStyle(
                            fontFamily: "Prompt",
                            fontSize: 50,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            Text(
                              question.name,
                              style: const TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 35,
                              ),
                            ),
                            const SizedBox(height: 15),
                            ...question.choices.map(
                              (choice) => ChoiceButton(
                                onPressed: () {
                                  _handleChangePage(choice);
                                },
                                buttonText: choice,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              default:
                return const SizedBox(
                  child: Text('data'),
                );
            }
          },
        ),
      ),
    );
  }

  void _handleChangePage(answer) {
    context.read<QuestionBloc>().add(QuestionNextPage(answer));
  }
}
