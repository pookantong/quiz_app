import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/quiz/quiz_bloc.dart';

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
              switch (state.runtimeType) {
                case LoadQuizSuccessfulState:
                  final successState = state as LoadQuizSuccessfulState;

                  return ListView.builder(
                    itemCount: successState.quizzes.length,
                    itemBuilder: (context, index) {
                      final quiz = successState.quizzes[index];
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
                default:
                  return const SizedBox(child: Text('data'),);
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _handleClickQuiz(BuildContext context, int quizId) async {
    context.read<QuestionBloc>().add(QuestionFirstLoadEvent(quizId));
  }
}
