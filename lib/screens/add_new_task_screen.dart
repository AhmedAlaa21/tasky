import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/home_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  ///TODO: DISPOSE THIS CONTROLLERS..
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
  TextEditingController();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF181818),
        centerTitle: false,
        iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
        title: Text('New Task'),
        titleTextStyle: TextStyle(color: Color(0xFFFFFCFC), fontSize: 20),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Task Name",
                          style: TextStyle(
                            color: Color(0xFFFFFCFC),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: taskNameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Finish UI design for login screen",
                            hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value
                                .trim()
                                .isEmpty) {
                              return "Please Enter Task Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Task Description",
                          style: TextStyle(
                            color: Color(0xFFFFFCFC),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: taskDescriptionController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText:
                            "Finish onboarding UI and hand off to devs by Thursday.",
                            hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          maxLines: 5,
                          validator: (String? value) {
                            if (value == null || value
                                .trim()
                                .isEmpty) {
                              return "Please Enter task description";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "High Priority?",
                              style: TextStyle(
                                color: Color(0xFFFFFCFC),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Switch(
                              value: isHighPriority,
                              onChanged: (bool value) {
                                setState(() {
                                  isHighPriority = value;
                                });
                              },
                              activeTrackColor: Color(0xFF15B86C),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("Add Task"),
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      TaskModel model = TaskModel(
                          taskName: taskNameController.text,
                          taskDescription: taskDescriptionController.text,
                          isHighPriority: isHighPriority);

                      final pref = await SharedPreferences.getInstance();

                      // get all previous tasks.
                      final previousTasks = pref.getString('tasks');

                      List<dynamic> tasksList = [];
                      if (previousTasks != null) {
                        tasksList =
                        jsonDecode(previousTasks);
                      }

                      tasksList.add(model.toJson());
                      await pref.setString("tasks", jsonEncode(tasksList));
                      print(tasksList);
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF15B86C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    fixedSize: Size(MediaQuery
                        .of(context)
                        .size
                        .width, 40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
