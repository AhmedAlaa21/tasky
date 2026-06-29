import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pref = await SharedPreferences.getInstance();
  String? username = pref.getString("username");
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFF181818),
      ),
      home: username == null ? WelcomeScreen() : HomeScreen(),
    );
  }
}
