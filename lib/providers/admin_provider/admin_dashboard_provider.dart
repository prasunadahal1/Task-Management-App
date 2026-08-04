import 'package:flutter/material.dart';

class AdminDashboardProvider extends ChangeNotifier{
  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  TextEditingController _descriptioncontroller = TextEditingController();
  TextEditingController get descriptioncontroller => _descriptioncontroller;

  TextEditingController _datecontroller = TextEditingController();
  TextEditingController get datecontroller => _datecontroller;

  TextEditingController _prioritycontroller = TextEditingController();
  TextEditingController get prioritycontroller => _prioritycontroller;

  TextEditingController _assigncontroller=TextEditingController();
  TextEditingController get assigncontroller=>_assigncontroller;

  TextEditingController _statuscontroller=TextEditingController();
  TextEditingController get statuscontroller=> _statuscontroller;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  final List<Map<String, dynamic>> projectList = [
    {
      "title": "Task Management App",
      "description": "This is Description1",
      "name": "Prasuna Dahal",
      "status": "In Progress",
      "priority": "HIGH",
      "date": "Due 29 Aug, 2026",
    },
    {
      "title": "GitHub Profile Viewer",
      "description": " This is Description2",
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
  final List<Map<String, dynamic>> employees = [
    {
      "id": 1,
      "name": "Dikshya karki",
      "role": "UI Designer",
    },
    {
      "id": 2,
      "name": "Bijay Sir",
      "role": "Lead Developer",
    },
    {
      "id": 3,
      "name": "Diwash Tiwari",
      "role": "Project Manager",
    },
    {
      "id": 4,
      "name": "Prasuna Dahal",
      "role": "QA Engineer",
    },
  ];

  final List<Map<String, dynamic>> statusList = [
    {
      "id": 1,
      "status": "Pending",
    },
    {
      "id": 2,
      "status": "In Progress",
    },
    {
      "id": 3,
      "status": "Completed",
    },
  ];
  Map<String, dynamic>? selectedEmployee;
  Map<String, dynamic>? selectedStatus;

  AdminDashboardProvider() {
    selectedStatus = statusList.first;
  }

  void changeEmployee(Map<String, dynamic>? value) {
    selectedEmployee = value;
    notifyListeners();
  }

  void changeStatus(Map<String, dynamic>? value) {
    selectedStatus = value;
    notifyListeners();
  }
}