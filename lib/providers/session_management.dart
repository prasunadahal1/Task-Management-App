import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManagement extends ChangeNotifier{
  static final SessionManagement _instance=SessionManagement();
  static SessionManagement get instance => _instance;

  String? userName;
  String? password;

  void setSession(String userName,String password)async{
    this.userName=userName;
    this.password=password;

     const storage =FlutterSecureStorage();
     await storage.write(key: 'userName', value: userName);
     await storage.write(key: 'password', value: password);
  }
  Future<void> loadSession()async{
    const storage=FlutterSecureStorage();
    final response=await Future.wait([
       storage.read(key:'userName'),
       storage.read(key:'password')
    ]);
    userName=response[0];
    password=response[1];

  }
  void clearSession(){
    
  }

}




