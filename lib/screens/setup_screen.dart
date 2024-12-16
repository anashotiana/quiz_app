import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _numQuestions = 5;
  String _category = "9"; // Default to General Knowledge
  String _difficulty = "easy";
  String _type = "multiple";

  final List<Map<String, String>> _categories = [
    {"id": "9", "name": "General Knowledge"},
    {"id": "21", "name": "Sports"},
    {"id": "11", "name": "Movies"},
  ];

  void _startQuiz() {
    // Navigate to Quiz Screen
    Navigator.pushNamed(context, '/quiz', arguments: {
      "numQuestions": _numQuestions,
      "category": _category,
      "difficulty": _difficulty,
      "type": _type,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Setup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Number of Questions:"),
            DropdownButton<int>(
              value: _numQuestions,
              items: [5, 10, 15]
                  .map((num) => DropdownMenuItem<int>(
                        value: num,
                        child: Text("$num Questions"),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _numQuestions = value!),
            ),
            const SizedBox(height: 16),
            Text("Category:"),
            DropdownButton<String>(
              value: _category,
              items: _categories
                  .map((cat) => DropdownMenuItem<String>(
                        value: cat["id"],
                        child: Text(cat["name"]!),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _category = value!),
            ),
            const SizedBox(height: 16),
            Text("Difficulty:"),
            DropdownButton<String>(
              value: _difficulty,
              items: ["easy", "medium", "hard"]
                  .map((diff) => DropdownMenuItem<String>(
                        value: diff,
                        child: Text(diff.capitalize()),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _difficulty = value!),
            ),
            const SizedBox(height: 16),
            Text("Type:"),
            DropdownButton<String>(
              value: _type,
              items: ["multiple", "boolean"]
                  .map((type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type == "multiple"
                            ? "Multiple Choice"
                            : "True/False"),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _type = value!),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _startQuiz,
                child: const Text("Start Quiz"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
