import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/bloc/question/question_bloc.dart';
import 'package:test_fl/src/bloc/quiz/quiz_bloc.dart';
import 'package:test_fl/src/pages/home/component/quiz_button.dart';
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
      backgroundColor: const Color(0xFFfed8c3),
      body: Stack(
        children: [
          BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case LoadQuizSuccessfulState:
                  final successState = state as LoadQuizSuccessfulState;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: successState.quizzes.length,
                          itemBuilder: (context, index) {
                            final quiz = successState.quizzes[index];
                            return QuizButton(
                              onPressed: () =>
                                  _handleClickQuiz(context, quiz.quizId),
                              name: quiz.name,
                              score: quiz.score,
                              completed: quiz.completed,
                            );
                          },
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  );

                default:
                  return const Center(
                    child: Text('Loading...'),
                  );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: IconButton(
                    alignment: Alignment.center,
                    onPressed: _handleClickPrevPage,
                    icon: const Icon(
                      size: 60,
                      Icons.navigate_before_outlined,
                      color: Color.fromARGB(255, 202, 152, 152),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: IconButton(
                    onPressed: _handleClickNextPage,
                    icon: const Icon(
                      size: 60,
                      Icons.navigate_next,
                      color: Color.fromARGB(255, 202, 152, 152),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: _handleCreateQuiz,
          child: Icon(
            Icons.add,
            size: 40,
            color: HexColor('#44564a'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

  void _handleClickNextPage() {
    context.read<QuizBloc>().add(IncreasePageEvent());
  }

  void _handleClickPrevPage() {
    context.read<QuizBloc>().add(DecreasePageEvent());
  }
}
