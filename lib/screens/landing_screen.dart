import 'package:flutter/material.dart';
import 'package:task_app/screens/addtask_screen.dart';
import 'package:task_app/screens/taskupdate_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('hello'),
        ),
      ),
    );
  }
}

