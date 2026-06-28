import 'package:flutter/material.dart';
import 'package:todo_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky',
      theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: Color(0xFF181818)  ),
      home: WelcomeScreen(),
    );
  }
}

