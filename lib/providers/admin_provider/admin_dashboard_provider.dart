import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


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

  List<Map<String, dynamic>> _category = [
    {'title': 'High', 'isSelected': false},
    {'title': 'Medium', 'isSelected': false},
    {'title': 'Low', 'isSelected': false},
  ];
  List<Map<String,dynamic>> get category=>_category;

  String? _title = "";
  String? get title=>_title;

  void chip( int index,dynamic value){
    _category[index]['isSelected'] = value;
    _title=_category[index]['title'];
    prioritycontroller.text = _title!;
    notifyListeners();
    print(title);
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  late List<Map<String, dynamic>> projectList = [
    {
      "Title": "Task Management App",
      "Description": "This is Description1",
      "Assign To": "Prasuna Dahal",
      "Status": "In Progress",
      "Priority": "HIGH",
      "Due Date": "Due 29 Aug, 2026",
    },
    {
      "Title": "GitHub Profile Viewer",
      "Description": " This is Description2",
      "Assign To": "Jyoti Mandal",
      "Status": "In Progress",
      "Priority": "High",
      "Date": "Due 29 Aug, 2026",
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
  final supabase =Supabase.instance.client;
  Map<String, dynamic>? selectedEmployee;
  Map<String, dynamic>? selectedStatus;

  AdminDashboardProvider() {
    selectedStatus = statusList.first;
  }

  void changeEmployee(value) {
    selectedEmployee = value;
    print(value);
    assigncontroller.text=value['Assign To'] ??"";
    print(value);
    notifyListeners();
  }

  void changeStatus(value) {
    selectedStatus = value;
    print(value);
    statuscontroller.text=value['Status']??"";
    print(value);
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

  //assign tasks in supabase
  Future<void> assignTask({
     required String title,
     required String description,
    required String dueDate,
    required String assignTo,
    required String status,
    required String priority,
  }) async {
    try {
      await supabase.from('AssignTask').insert({
        'Title': title,
        'Description': description,
        'Due Date': dueDate,
        'Assign To':assignTo,
        'Status':status,
        'Priority': priority,
      });
      print('provider assigntask');
      await fetchTask();
      print('provider assigntask');

    } catch (e) {
      print(e);
    }
  }

  Future<void>fetchTask()async{
    try {
      final data = await supabase
          .from('AssignTask')
          .select()
          .order('created_at', ascending: false);

      projectList = List<Map<String, dynamic>>.from(data as List);
    } catch (e) {
     print(e);
    }
  }
}