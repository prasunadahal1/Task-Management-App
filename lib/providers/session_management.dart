import 'dart:convert';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_app/resources/main_screen.dart';
import 'package:task_app/screens/splash_screen.dart';

class SessionManagement extends ChangeNotifier{

  TextEditingController _namecontroller=TextEditingController();
  TextEditingController get namecontroller=>_namecontroller;

  TextEditingController _passwordcontroller=TextEditingController();
  TextEditingController get passwordcontroller=>_passwordcontroller;

  static final SessionManagement _instance=SessionManagement();
  static SessionManagement get instance => _instance;

  String? userName;
  String? password;
  String? _accessToken;
  String? _refreshToken;
  String? get accessToken=>_accessToken;
  String? get refreshToken=>_refreshToken;

  Map<String,dynamic> _data={};
  Map<String,dynamic> get data=>_data;

  void postData(String username,String password,context) async{
    Response response =await post(Uri.parse("https://dummyjson.com/auth/login"),
    headers: {'content-type':'application/json'},
        body: jsonEncode({
          'username':username,
          'password':password,
        })
    );
    if(response.statusCode==200||response.statusCode==201){
     final data=jsonDecode(response.body);
     _accessToken=data['accessToken'];
     _refreshToken=data['refreshToken'];
     setSession(_accessToken!);
     setRefreshSession(_refreshToken!);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.white,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 110,left: 16,right: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF84C5A5)),
                  SizedBox(width: 10),
                  Text('Don\'t use my app',style: TextStyle(color:Colors.black)),
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
      headers: {'content-type': 'application/json','Accept': 'application/json'},
        body: jsonEncode({
          'refreshToken':_refreshToken,
          'expiresInMins':30,
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
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.white,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 110,left: 16,right: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF84C5A5)),
                  SizedBox(width: 10),
                  Text('${e}',style: TextStyle(color:Colors.black)),
                ],
              )));
    }

  }
  void setSession(String accessToken)async{
     const storage =FlutterSecureStorage();
     await storage.write(key: "accessToken",value: accessToken);
     notifyListeners();
  }
 Future<void> setRefreshSession(String refreshToken)async{
    const storage =FlutterSecureStorage();
    await storage.write(key: "refreshToken",value: refreshToken);
    _refreshToken = refreshToken;
    final token=await storage.read(key: 'refreshToken');
    notifyListeners();
  }

  Future<void> loadSession()async{
    const storage=FlutterSecureStorage();
    final response=await Future.wait([
      storage.read(key:'accessToken'),
      storage.read(key:'refreshToken'),

    ]);
    _accessToken=response[0];
    _refreshToken=response[1];

    notifyListeners();
  }
  void clearSession()async{
    _accessToken=null;
    _refreshToken=null;
    const storage=FlutterSecureStorage();
    await Future.wait([
      storage.delete(key: 'accessToken'),
      storage.delete(key: 'refreshToken'),

    ]);
    notifyListeners();
  }

}




