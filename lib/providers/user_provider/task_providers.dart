import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';

class TaskProvider extends ChangeNotifier {

  String? _title = "";
  String? get title=>_title;

  List<dynamic> _data =[];
  List<dynamic> get data=> _data;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
  List<Map<String, dynamic>> _category = [
    {'title': 'Work', 'isSelected': false},
    {'title': 'Meeting', 'isSelected': false},
    {'title': 'Study', 'isSelected': false},
    {'title': 'Personal', 'isSelected': false},
    {'title': 'Work', 'isSelected': false},
    {'title': 'Work', 'isSelected': false},
    {'title': 'Work', 'isSelected': false},
  ];
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
  String? _id;

  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get id => _id;

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

  List<dynamic> _filteredLists = [];
  List<dynamic> get filteredLists => _filteredLists;
  List<Map<String, dynamic>> get tasks => _tasks;
  List<Map<String,dynamic>> get category=>_category;

  void chip( int index,dynamic value){
    _category[index]['isSelected'] = value;
    _title=_category[index]['title'];
    notifyListeners();
    print(title);
  }

  Future<bool> addTask(
    String title,
    String description,
    String date,
    String startTime,
    String endTime,
    String category,
    context,
  ) async {
    Response response = await post(
      Uri.parse(
        'https://6a2a90b7b687a7d5cbc3fb8a.mockapi.io/api/prasuna/tasks/todo',
      ),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'description': description,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'category': category,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final task = jsonDecode(response.body) as Map<String, dynamic>;
      _data.add(task);
      _filteredLists = List<dynamic>.from(_data);
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  void controllerclear(){
    controller.clear();
    descriptioncontroller.clear();
    datecontroller.clear();
    startTimeController.clear();
    endTimeController.clear();
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
    final startTime = startTimeController.text.isNotEmpty
        ? startTimeController.text
        : _startTime;
    final endTime = endTimeController.text.isNotEmpty
        ? endTimeController.text
        : _endTime;
    final updatedTask = {
      ...Map<String, dynamic>.from(filteredLists[index] as Map),
      'title': controller.text,
      'description': descriptioncontroller.text,
      'date': datecontroller.text,
      'startTime': startTime,
      'endTime': endTime,
      'category': categorycontroller.text,
    };
    _filteredLists[index] = updatedTask;

    final id = updatedTask['id'];
    if (id != null) {
      final dataIndex = _data.indexWhere((task) => task['id'] == id);
      if (dataIndex != -1) {
        _data[dataIndex] = Map<String, dynamic>.from(updatedTask);
      }
    }
    notifyListeners();
  }

  Future<bool> editData(
    String title,
    String description,
    String date,
    String startTime,
    String endTime,
    String category,
    String id,
  ) async {
    final start = startTimeController.text.isNotEmpty
        ? startTimeController.text
        : _startTime;
    final end = endTimeController.text.isNotEmpty
        ? endTimeController.text
        : _endTime;
    final body = {
      'title': controller.text,
      'description': descriptioncontroller.text,
      'date': datecontroller.text,
      'startTime': start,
      'endTime': end,
      'category': categorycontroller.text,
    };
    Response response = await put(
      Uri.parse(
        "https://6a2a90b7b687a7d5cbc3fb8a.mockapi.io/api/prasuna/tasks/todo/$id",
      ),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final dataIndex = _data.indexWhere((task) => task['id'].toString() == id);
      if (dataIndex != -1) {
        _data[dataIndex] = {
          ...Map<String, dynamic>.from(_data[dataIndex] as Map),
          ...body,
          'id': _data[dataIndex]['id'],
        };
      }
      _filteredLists = List<dynamic>.from(_data);
      notifyListeners();
      return true;
    }
    return false;
  }
  // void searchFilter(String keyword) {
  //   String normalize(String text) =>
  //       text.toLowerCase().replaceAll(RegExp(r'\s+'), '').trim();
  //   final String normalizedKeyword = normalize(keyword);
  //   if (keyword.isEmpty) {
  //     _filteredLists = List<Map<String, dynamic>>.from(_data);
  //   } else {
  //     _filteredLists = _data.where((data) {
  //     return normalize(data.title ?? '')
  //         .contains(normalizedKeyword);
  //   }).toList();
  //     // _filteredLists = _data.where((data) {
  //     //   final String normalizedName = normalize(data['title'].toString());
  //     //   return normalizedName.contains(normalizedKeyword);
  //     // }).toList();
  //     // _filteredLists = _tasks.where((info) {
  //     //
  //     //   final String normalizedName = normalize(info['title'].toString());
  //     //   // final String normalizedId =info['author']['id'].toString();
  //     //   return normalizedName.contains(normalizedKeyword);
  //     //   // ||normalizedId.contains(normalizedKeyword);
  //     // }).toList();
  //   }
  //   notifyListeners();
  // }
  TaskProvider() {
    _filteredLists = List<dynamic>.from(_data);
  }

  Future<void> getData () async{
    Response response=await get(Uri.parse('https://6a2a90b7b687a7d5cbc3fb8a.mockapi.io/api/prasuna/tasks/todo'));
    _data = jsonDecode(response.body);
    _filteredLists = List<dynamic>.from(_data);
    notifyListeners();
  }

  // void setId(value){
  //   _id=value;
  //  notifyListeners();
  // }

Future<void> deleteData(String id)async{
    Response response=await delete(Uri.parse('https://6a2a90b7b687a7d5cbc3fb8a.mockapi.io/api/prasuna/tasks/todo/$id'));
    _data.removeWhere((task) => task['id'] == id);
    _filteredLists.removeWhere((task) => task['id'] == id);
    notifyListeners();
}

  void searchFilter(String keyword) {
    String normalize(String text) =>
        text.toLowerCase().replaceAll(RegExp(r'\s+'), '').trim();

    final String normalizedKeyword = normalize(keyword);

    if (keyword.isEmpty) {
      _filteredLists = List<dynamic>.from(_data);
    } else {
      _filteredLists = _data.where((data) {
        if (data is Map<String, dynamic>) {
          final String normalizedName =
          normalize(data['title']?.toString() ?? '');

          return normalizedName.contains(normalizedKeyword);
        }
        return false;
      }).toList();
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

  void initEditTask({
    required String title,
    required String desc,
    required String date,
    required String startTime,
    required String endTime,
    required String category,
  }) {
    _controller.text = title;
    _descriptioncontroller.text = desc;
    _datecontroller.text = date;
    _startTimeController.text = startTime;
    _endTimeController.text = endTime;
    _categorycontroller.text = category;
    _startTime = startTime;
    _endTime = endTime;
    notifyListeners();
  }

  void clearControllers() {
    _controller.clear();
    _descriptioncontroller.clear();
    _datecontroller.clear();
    _startTimeController.clear();
    _endTimeController.clear();
    _categorycontroller.clear();
    _startTime = null;
    _endTime = null;
    notifyListeners();
  }
}


