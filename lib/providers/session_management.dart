import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManagement extends ChangeNotifier{

  // TextEditingController _namecontroller=TextEditingController();
  // TextEditingController get namecontroller=>_namecontroller;
  //
  // TextEditingController _passwordcontroller=TextEditingController();
  // TextEditingController get passwordcontroller=>_passwordcontroller;

  static final SessionManagement _instance=SessionManagement();
  static SessionManagement get instance => _instance;

  String? userName;
  String? password;

  void setSession(String userName,String password)async{
    userName=userName;
    password=password;

     const storage =FlutterSecureStorage();
     await storage.write(key: 'userName', value: userName);
     await storage.write(key: 'password', value: password);
     notifyListeners();
  }
  Future<void> loadSession()async{
    const storage=FlutterSecureStorage();
    final response=await Future.wait([
       storage.read(key:'userName'),
       storage.read(key:'password')
    ]);
    userName=response[0];
    password=response[1];
    notifyListeners();
  }
  void clearSession()async{
    userName=null;
    password=null;
    const storage=FlutterSecureStorage();
    await Future.wait([
      storage.delete(key: 'userName'),
      storage.delete(key: 'password'),
    ]);
    notifyListeners();
  }

}




