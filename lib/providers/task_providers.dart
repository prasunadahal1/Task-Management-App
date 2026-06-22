import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class TaskProvider extends ChangeNotifier {
  List<dynamic> _data =[];
  List<dynamic> get data=> _data;

  Uint8List? _image;
  Uint8List? get image => _image;

  Uint8List? _img;
  Uint8List? get img => _img;

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

  Future<bool> addTask (
    String title,
    String description,
    String date,
    String startTime,
    String endTime,
    String category,
      context,
  ) async {
    filteredLists.add({
      'title': title,
      'description': description,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'category': category,
    });
    Response response=await post(Uri.parse('https://6a2a90b7b687a7d5cbc3fb8a.mockapi.io/api/prasuna/tasks/todo'),
      headers:{'content-type':'application/json'},
      body: jsonEncode({
        'title':controller.text,
        'description':descriptioncontroller.text,
        'date':datecontroller.text,
        'starttime':_startTime,
        'endtime':_endTime,
        'category':categorycontroller.text,
      }),
    );;
    notifyListeners();
    print(response.statusCode);
    return response.statusCode==200|| response.statusCode==201;
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

  // void deleteTask(int index) {
  //   filteredLists.removeAt(index);
  //   notifyListeners();
  // }

  void editTask(int index) {
    filteredLists[index]['title'] = controller.value.text;
    filteredLists[index]['description'] = descriptioncontroller.value.text;
    filteredLists[index]['date'] = datecontroller.value.text;
    filteredLists[index]['startTime'] = _startTime;
    filteredLists[index]['endTime'] = _endTime;
    filteredLists[index]['category'] = categorycontroller.value.text;
    notifyListeners();
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

Future<dynamic> pickImage(ImageSource source) async{
    final ImagePicker _imagepicker =ImagePicker();
    XFile? _file= await _imagepicker.pickImage(source: source);

    if (_file != null) {
        return await _file.readAsBytes();
    }
    notifyListeners();
}

 Future<dynamic> selectImage()async{
   _image = await pickImage(ImageSource.gallery);
  if (_img!= null){
    _image=_img!;
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
    notifyListeners();
  }

  void clearControllers() {
    _controller.clear();
    _descriptioncontroller.clear();
    _datecontroller.clear();
    _startTimeController.clear();
    _endTimeController.clear();
    _categorycontroller.clear();
  }
}


