import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final Map<String, dynamic> results;

  const SummaryScreen({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int score = results['score'];
    final int totalQuestions = results['totalQuestions'];

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Summary")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Your Score: $score/$totalQuestions",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text("Return to Setup"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Retake Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}
