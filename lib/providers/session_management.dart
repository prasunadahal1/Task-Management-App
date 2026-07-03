import 'dart:convert';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_app/resources/main_screen.dart';

class SessionManagement extends ChangeNotifier {
  static const _storage = FlutterSecureStorage();

  TextEditingController _namecontroller = TextEditingController();

  TextEditingController get namecontroller => _namecontroller;

  TextEditingController _passwordcontroller = TextEditingController();

  TextEditingController get passwordcontroller => _passwordcontroller;

  static final SessionManagement _instance = SessionManagement();

  static SessionManagement get instance => _instance;

  String? userName;
  String? password;
  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  Future<void> postData(String username,
      String password,
      BuildContext context,) async {
    Response response = await post(
      Uri.parse("https://dummyjson.com/auth/login"),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      _accessToken = data['accessToken'];
      _refreshToken = data['refreshToken'];
      await setSession(_accessToken!);
      await setRefreshSession(_refreshToken!);
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.white,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: MediaQuery
                  .of(context)
                  .size
                  .height - 110, left: 16, right: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(15)),
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF84C5A5)),
                  SizedBox(width: 10),
                  Text('Don\'t use my app',
                      style: TextStyle(color: Colors.black)),
                ],
              )));
    }
    notifyListeners();
    // print(response.body);
    // print(_accessToken);
    print(_refreshToken);
  }


  Future<void> refreshSession(context) async {
    print('hi');
    try {
      print('hello');
      Response response = await post(
          Uri.parse("https://dummyjson.com/auth/refresh"),
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({
            'refreshToken': _refreshToken,
            'expiresInMins': 30,
          })
      );
      print('hello');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.white,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: MediaQuery
                  .of(context)
                  .size
                  .height - 110, left: 16, right: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(15)),
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF84C5A5)),
                  SizedBox(width: 10),
                  Text('${e}', style: TextStyle(color: Colors.black)),
                ],
              )));
    }
  }

  Future<void> setSession(String accessToken) async {
    await _storage.write(key: "accessToken", value: accessToken);
    _accessToken = accessToken;
    notifyListeners();
  }

  Future<void> setRefreshSession(String refreshToken) async {
    await _storage.write(key: "refreshToken", value: refreshToken);
    _refreshToken = refreshToken;
    notifyListeners();
  }

  Future<void> loadSession() async {
    final response = await Future.wait([
      _storage.read(key: 'accessToken'),
      _storage.read(key: 'refreshToken'),
    ]);
    _accessToken = response[0];
    _refreshToken = response[1];

    notifyListeners();
  }

  Future<void> clearSession() async {
    _accessToken = null;
    _refreshToken = null;
    await Future.wait([
      _storage.delete(key: 'accessToken'),
      _storage.delete(key: 'refreshToken'),
    ]);
    notifyListeners();
  }

  Future<void> saveUserData(Map<String, dynamic> user) async {
    const storage = FlutterSecureStorage();

    await storage.write(
      key: "user",
      value: jsonEncode(user),
    );
  }

  Map<String, dynamic> user = {};

  Future<void> loadUserData() async {
    const storage = FlutterSecureStorage();

    final value = await storage.read(key: "user");

    if (value != null) {
      user = jsonDecode(value);
    }

    notifyListeners();
  }
}




