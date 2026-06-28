import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
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
                            "Good Evening ,Usama",
                            style: TextStyle(
                              color: Color(0xFFFFFCFC),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "One task at a time.One step\n closer.",
                            style: TextStyle(
                              color: Color(0xFFC6C6C6),
                              fontWeight: FontWeight.w400,
                              fontSize: 14
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text("button here..",
                  style: TextStyle(color: Colors.white),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
