import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/add_new_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = "Guest";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('username') ?? "Guest";
    });
  }

  String _getGreeting() {
    final int hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    if (hour < 21) return "Good Evening";
    return "Good Night";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF15B86C),
          foregroundColor: Colors.white,
          fixedSize: Size(167, 40),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return AddNewTaskScreen();
              },
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text("Add New Task"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/person-ph.png",
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_getGreeting()}, $username",
                            style: TextStyle(
                              color: Color(0xFFFFFCFC),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "One task at a time. One step\n closer.",
                            style: TextStyle(
                              color: Color(0xFFC6C6C6),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.sunny, color: Colors.white),
                ],
              ),
              SizedBox(height: 16),

              Text(
                "Yuhuu, Your work is",
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontWeight: FontWeight.w400,
                  fontSize: 32,
                ),
              ),
              Row(
                children: [
                  Text(
                    "almost done!",
                    style: TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                    ),
                  ),
                  SvgPicture.asset("assets/images/waving-hand.svg"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
