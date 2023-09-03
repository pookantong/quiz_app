import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/quiz/quiz_bloc.dart';
import 'package:test_fl/src/pages/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
      body: Stack(
        children: [
          Center(
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
                            onPressed: () =>
                                _handleClickQuiz(context, quiz.quizId),
                            child: Text(quiz.name),
                          ),
                        );
                      },
                    );
                  default:
                    return const SizedBox(
                      child: Text('data'),
                    );
                }
              },
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                _handleCreateQuiz();
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleClickQuiz(BuildContext context, int quizId) async {
    context.read<QuestionBloc>().add(QuestionFirstLoadEvent(quizId));
  }

  void _handleCreateQuiz() {
    Navigator.pushNamed(
      navigatorState.currentContext!,
      AppRoute.create,
    );
  }
}
