import 'package:flutter/material.dart';
import 'package:customizable_quiz_app/screens/setup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customizable Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SetupScreen(),
    );
  }
}
