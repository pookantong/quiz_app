import 'package:flutter/material.dart';
import 'package:test_fl/src/models/question.dart';

class QuestionForm extends StatefulWidget {
  final Function(QuestionFormModel) onQuestionAdded;

  QuestionForm({required this.onQuestionAdded});

  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _choicesController = TextEditingController();
  final TextEditingController _correctAnswerController =
      TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  List<String> choices = [];

  @override
  void dispose() {
    _nameController.dispose();
    _choicesController.dispose();
    _correctAnswerController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  void addChoice() {
    if (_choicesController.text.isNotEmpty) {
      setState(() {
        choices.add(_choicesController.text);
        _choicesController.clear();
      });
    }
  }

  void saveQuestion() {
    if (_formKey.currentState!.validate() && choices.isNotEmpty) {
      final newQuestion = QuestionFormModel(
        name: _nameController.text,
        choices: choices,
        correctAnswer: _correctAnswerController.text,
        score: int.tryParse(_scoreController.text) ?? 0,
      );
      widget.onQuestionAdded(newQuestion);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfed8c3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Question Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a question name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _choicesController,
                  decoration: const InputDecoration(labelText: 'Choice'),
                ),
                ElevatedButton(
                  onPressed: addChoice,
                  child: Text('Add Choice'),
                ),
                Text('Choices: ${choices.join(", ")}'),
                TextFormField(
                  controller: _correctAnswerController,
                  decoration: InputDecoration(labelText: 'Correct Answer'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a correct answer';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _scoreController,
                  decoration: const InputDecoration(labelText: 'Score'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: saveQuestion,
                  child: const Text('Save Question'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
