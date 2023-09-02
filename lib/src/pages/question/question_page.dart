import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/result/result_bloc.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<QuestionBloc, QuestionState>(
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
              return Column(
                children: [
                  LinearProgressIndicator(value: question.progress / 100),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            question.name,
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                        ...question.choices.map(
                          (answer) => ElevatedButton(
                            onPressed: () {
                              _handleChangePage(answer);
                            },
                            child: Text(answer),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            default:
              return const SizedBox(
                child: Text('data'),
              );
          }
        },
      ),
    );
  }

  void _handleChangePage(answer) {
    context.read<QuestionBloc>().add(QuestionNextPage(answer));
  }
}
