import 'package:flutter/material.dart';

class AdminDashboardProvider extends ChangeNotifier{
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  final List<Map<String, dynamic>> projectList = [
    {
      "title": "Task Management App",
      "name": "Prasuna Dahal",
      "status": "In Progress",
      "priority": "HIGH",
      "date": "Due 29 Aug, 2026",
    },
    {
      "title": "GitHub Profile Viewer",
      "name": "Jyoti Mandal",
      "status": "In Progress",
      "priority": "High",
      "date": "Due 29 Aug, 2026",
    },
  ];

  final List<Map<String,dynamic>> overview=[
    {
      "icon":Icons.task,
      "count":"10",
      "title":"Tasks",
      "subtitle":"Total"

    },
    {
      "icon":Icons.check_circle_outline,
      "count":"5",
      "title":"Tasks",
      "subtitle":"Completed"
    }
  ];
  final List<Map<String,dynamic>> overview1=[
    {
      "icon":Icons.hourglass_bottom,
      "count":"10",
      "title":"Tasks",
      "subtitle":"Pending"

    },
    {
      "icon":Icons.cancel,
      "count":"5",
      "title":"Tasks",
      "subtitle":"Canceled"
    }
  ];

}