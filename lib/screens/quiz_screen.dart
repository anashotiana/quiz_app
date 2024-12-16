import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizScreen extends StatefulWidget {
  final Map<String, dynamic> settings;

  const QuizScreen({Key? key, required this.settings}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<dynamic>> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = true;
  bool _isAnswered = false;
  String _feedback = "";

  @override
  void initState() {
    super.initState();
    _questions = _fetchQuestions();
  }

  Future<List<dynamic>> _fetchQuestions() async {
    final url =
        'https://opentdb.com/api.php?amount=${widget.settings['numQuestions']}&category=${widget.settings['category']}&difficulty=${widget.settings['difficulty']}&type=${widget.settings['type']}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception("Failed to fetch questions");
    }
  }

  void _answerQuestion(String selectedAnswer) {
    setState(() {
      _isAnswered = true;

      final correctAnswer =
          _questions as List<dynamic>[_currentQuestionIndex]['correct_answer'];
      if (selectedAnswer == correctAnswer) {
        _feedback = "Correct!";
        _score++;
      } else {
        _feedback = "Incorrect! Correct answer: $correctAnswer";
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isAnswered = false;
        _feedback = "";

        if (_currentQuestionIndex < (_questions as List<dynamic>).length - 1) {
          _currentQuestionIndex++;
        } else {
          _endQuiz();
        }
      });
    });
  }

  void _endQuiz() {
    Navigator.pushNamed(context, '/summary', arguments: {
      "score": _score,
      "totalQuestions": (_questions as List<dynamic>).length,
      "questions": _questions,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: FutureBuilder<List<dynamic>>(
        future: _questions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No questions available."));
          }

          final question = snapshot.data![_currentQuestionIndex];
          final answers = [...question['incorrect_answers'], question['correct_answer']];
          answers.shuffle();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Question ${_currentQuestionIndex + 1}/${snapshot.data!.length}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  question['question'],
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 16),
                ...answers.map((answer) {
                  return ElevatedButton(
                    onPressed: _isAnswered
                        ? null
                        : () => _answerQuestion(answer),
                    child: Text(answer),
                  );
                }).toList(),
                const Spacer(),
                if (_isAnswered)
                  Center(
                    child: Text(
                      _feedback,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
