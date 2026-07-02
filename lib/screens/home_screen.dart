import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/add_new_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = "Guest";
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadTasks();
  }

  void _loadUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.clear();
    setState(() {
      username = pref.getString('username') ?? "Guest";
    });
  }

  void _loadTasks() async {
    final pref = await SharedPreferences.getInstance();
    final tasksList = pref.getString('tasks');

    if (tasksList == null) return;

    setState(() {
      final List<dynamic> decoded = jsonDecode(tasksList);
      tasks = decoded
          .map((item) => TaskModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
    print(tasks[0].isDone);
  }

  String _getGreeting() {
    final int hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    if (hour < 21) return "Good Evening";
    return "Good Night";
  }

  Widget renderTasks() {
    if (tasks.isEmpty) {
      return Center(
        child: Text(
          "No tasks added yet!",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            color: Color(0xFF2A2A2A),
            margin: EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Checkbox(
                value: task.isDone,
                onChanged: (bool? value) async {
                  setState(() {
                    task.isDone = value ?? false;
                  });

                  // updated tasks with isDone toggle.
                  final pref = await SharedPreferences.getInstance();
                  final updatedTask = tasks
                      .map((element) => element.toJson())
                      .toList();
                  pref.setString('tasks', jsonEncode(updatedTask));
                },
                activeColor: Color(0xFF15B86C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Color(task.isDone ? 0xFFA0A0A0 : 0xFFC6C6C6),
                ),
                onPressed: () {
                  print('got clicked!');
                },
              ),
              contentPadding: EdgeInsets.all(0),
              title: Text(
                task.taskName,
                style: TextStyle(
                  color: Color(task.isDone ? 0xFFA0A0A0 : 0xFFFFFCFC),
                  fontWeight: FontWeight.w600,
                  decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Color(task.isDone ? 0xFFA0A0A0 : 0xFFFFFCFC),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              titleAlignment: ListTileTitleAlignment.center,
              subtitle: Text(
                task.taskDescription,
                style: TextStyle(color: Color(0xFFC6C6C6)),
              ),
            ),
          );
        },
      ),
    );
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
              builder: (BuildContext context) => AddNewTaskScreen(),
            ),
          ).then(
            (_) => _loadTasks(),
          ); // reload tasks when returning from AddNewTaskScreen
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
              SizedBox(height: 20),
              Text(
                "My Tasks",
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16),
              renderTasks(),
            ],
          ),
        ),
      ),
    );
  }
}
