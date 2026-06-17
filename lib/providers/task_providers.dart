import 'dart:math';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
  List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Learn Flutter',
      'description': 'Add Details',
      'date': '2083-02-30',
      'startTime': '7:00am',
      'endTime': '5:00pm',
      'category': 'Work',
    },
    {
      'title': 'Make Weather App',
      'description': 'Add Details',
      'date': '2083-02-30',
      'startTime': '7:00am',
      'endTime': '5:00pm',
      'category': 'Work',
    },
    {
      'title': 'Make Todo app',
      'description': 'Add Details',
      'date': '2083-02-30',
      'startTime': '7:00am',
      'endTime': '5:00pm',
      'category': 'Work',
    },
  ];
  String? _startTime;
  String? _endTime;

  String? get startTime => _startTime;
  String? get endTime => _endTime;

  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  TextEditingController _descriptioncontroller = TextEditingController();
  TextEditingController get descriptioncontroller => _descriptioncontroller;

  TextEditingController _datecontroller = TextEditingController();
  TextEditingController get datecontroller => _datecontroller;

  TextEditingController _startTimeController = TextEditingController();
  TextEditingController get startTimeController => _startTimeController;

  TextEditingController _endTimeController = TextEditingController();
  TextEditingController get endTimeController => _endTimeController;

  TextEditingController _categorycontroller = TextEditingController();
  TextEditingController get categorycontroller => _categorycontroller;

  List<Map<String, dynamic>> _filteredLists = [];
  List<Map<String, dynamic>> get filteredLists => _filteredLists;
  List<Map<String, dynamic>> get tasks => _tasks;

  void addTask(
    String title,
    String description,
    String date,
    String startTime,
    String endTime,
    String category,
  ) {
    filteredLists.add({
      'title': title,
      'description': description,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'category': category,
    });
    notifyListeners();
  }

  void pickDate(context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickDate != null) {
      _datecontroller.text = DateFormat('yyyy-MM-dd').format(pickDate);
    }
    notifyListeners();
  }

  void deleteTask(int index) {
    filteredLists.removeAt(index);
    notifyListeners();
  }

  void editTask(int index) {
    filteredLists[index]['title'] = controller.value.text;
    filteredLists[index]['description'] = descriptioncontroller.value.text;
    filteredLists[index]['date'] = datecontroller.value.text;
    filteredLists[index]['startTime'] = _startTime;
    filteredLists[index]['endTime'] = _endTime;
    filteredLists[index]['category'] = categorycontroller.value.text;
    notifyListeners();
  }

  TaskProvider() {
    _filteredLists = List<Map<String, dynamic>>.from(_tasks);
  }

  void searchFilter(String keyword) {
    String normalize(String text) =>
        text.toLowerCase().replaceAll(RegExp(r'\s+'), '').trim();
    final String normalizedKeyword = normalize(keyword);
    if (keyword.isEmpty) {
      _filteredLists = List<Map<String, dynamic>>.from(_tasks);
    } else {
      _filteredLists = _tasks.where((info) {
        final String normalizedName = normalize(info['title'].toString());
        return normalizedName.contains(normalizedKeyword);
      }).toList();


      // _filteredLists = _tasks.where((info) {
      //
      //   final String normalizedName = normalize(info['title'].toString());
      //   // final String normalizedId =info['author']['id'].toString();
      //   return normalizedName.contains(normalizedKeyword);
      //   // ||normalizedId.contains(normalizedKeyword);
      // }).toList();
    }
    notifyListeners();
  }

  void pickStartTime(context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      type: OmniDateTimePickerType.time,
      is24HourMode: false,
    );
    if (dateTime != null) {
      _startTime = DateFormat('hh:mm a').format(dateTime);
      _startTimeController.text = _startTime!;
    }
    notifyListeners();
  }

  void pickEndTime(context) async {
    DateTime? picked = await showOmniDateTimePicker(
      context: context,
     type: OmniDateTimePickerType.time,
    );
    if (picked != null) {
      _endTime =DateFormat('hh:mm a').format(picked);
      _endTimeController.text = _endTime!;
    }
    notifyListeners();
  }

}


