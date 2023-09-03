import 'package:flutter/material.dart';
import 'package:test_fl/src/app.dart';
import 'package:test_fl/src/models/question.dart';
import 'package:test_fl/src/models/quiz.dart';
import 'package:test_fl/src/pages/create_quiz/question_form.dart';
import 'package:test_fl/src/pages/routes.dart';
import 'package:test_fl/src/services/api_service.dart';

class QuizCreatePage extends StatefulWidget {
  const QuizCreatePage({super.key});

  @override
  State<QuizCreatePage> createState() => _QuizCreatePageState();
}

class _QuizCreatePageState extends State<QuizCreatePage> {
  String quizName = '';
  List<QuestionFormModel> quizQuestions = [];

  void addQuestion(QuestionFormModel question) {
    setState(() {
      quizQuestions.add(question);
    });
  }

  Future<void> submitQuiz() async {
    QuizFormModel quizFormModel = QuizFormModel(
      name: quizName,
      score: calculateTotalScore(),
      questions: quizQuestions,
    );
    bool status = await ApiService().createQuiz(quizFormModel);
    if (status) {
      Navigator.pop(
        navigatorState.currentContext!,
        AppRoute.home,
      );
    }
  }

  int calculateTotalScore() {
    int totalScore = 0;
    for (var question in quizQuestions) {
      totalScore += question.score;
    }
    return totalScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Total Score: ${calculateTotalScore()}'),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quiz Name'),
                onChanged: (value) {
                  setState(() {
                    quizName = value;
                  });
                },
              ),
              for (int i = 0; i < quizQuestions.length; i++)
                Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Question ${i + 1}: ${quizQuestions[i].name}'),
                        Text('Choices: ${quizQuestions[i].choices.join(", ")}'),
                        Text(
                            'Correct Answer: ${quizQuestions[i].correctAnswer}'),
                        Text('Score: ${quizQuestions[i].score}'),
                      ],
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionForm(
                        onQuestionAdded: addQuestion,
                      ),
                    ),
                  );
                },
                child: Text('Add Question'),
              ),
              ElevatedButton(
                onPressed: submitQuiz,
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
