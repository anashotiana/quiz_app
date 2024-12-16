import 'package:flutter/material.dart';

class QuizProgressIndicator extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const QuizProgressIndicator({
    Key? key,
    required this.currentQuestion,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: currentQuestion / totalQuestions,
      backgroundColor: Colors.grey[300],
      color: Colors.blue,
    );
  }
}
