import 'dart:convert';
import 'dart:typed_data';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_app/Auth/login_screen.dart';
import 'package:task_app/admin_screen/admin_dashboard.dart';
import 'package:task_app/admin_screen/admin_mainscreen.dart';
import 'package:task_app/user_screen/main_screen.dart';
import 'package:task_app/user_screen/home_screen.dart';

class SessionManagement extends ChangeNotifier {
  static const _storage = FlutterSecureStorage();

  TextEditingController _namecontroller=TextEditingController();
  TextEditingController get namecontroller=> _namecontroller;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController get emailcontroller => _emailcontroller;

  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController get passwordcontroller => _passwordcontroller;

  static final SessionManagement _instance = SessionManagement();

  static SessionManagement get instance => _instance;
  String? userName;
  String? email;
  String? password;
  String? _accessToken;
  String? _refreshToken;


  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  String? _image;
  String? get image => _image;

  Uint8List? _img;
  Uint8List? get img => _img;
  final supabase =Supabase.instance.client;

  //login as admin
  Future<int?>getUserRole()async{
    final user = supabase.auth.currentUser;
    if(user==null) return null;
    final data=await supabase.from('users').select('role_id').eq('id',user.id).single();
    return data['role_id']as int?;
  }
  //supbase login
  login(context)async{
    try{
      final result=await supabase.auth.signInWithPassword(email:emailcontroller.text.trim(),password: passwordcontroller.text.trim());
      final int? role =await getUserRole();
      print(role);
      emailcontroller.clear();
      passwordcontroller.clear();
      if (!context.mounted) return;
      if(role==1){
        print("hello");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminMainscreen()),
        );
      }else
        {
          print("hello2");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
      // if(result.user!= null && result.session!= null){
      //   Navigator.pushNamed(context, await Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => HomeScreen())));
      // }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }

  register(context)async{
    try{
      final result=await supabase.auth.signUp(email:emailcontroller.text.trim(),password: passwordcontroller.text.trim());
      print("Signing up with: $result");
      if(result.user!= null && result.session!= null){
        await supabase.from('users').insert({
          'id':result.user!.id,
          'name':namecontroller.text,
          'email':emailcontroller.text,
        });
        namecontroller.clear();
        emailcontroller.clear();
        passwordcontroller.clear();
        print("User table insert success");
        Navigator.pushNamed(context, await Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
      }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }

  nextScreen(BuildContext context) async{
    await Future.delayed(Duration(seconds:3));
    if(supabase.auth.currentSession==null){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen())
      );
    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen())
      );
    }
  }

  Future<void>getUserData()async{
    final user= supabase.auth.currentUser;
     if(user== null)return;
     final data=await supabase.from('users').select('name,email,profilepic').eq("id", user.id).single();
    print(data);
     userName=data['name'];
     email=data['email'];
    _image=data['profilepic'];
     notifyListeners();
  }

  //supabase image upload
  Future<void> uploadImageToSupabase(Uint8List imageBytes) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;
      final fileName = "${user.id}.png";
      //upload image to bucket
      await supabase.storage
          .from('user_pic')
          .uploadBinary(
        'image/$fileName',
        imageBytes,

        fileOptions: const FileOptions(
          upsert: true,
          contentType: 'image/png',
        ),
      );
      //convert uploaded image into url
      final imageUrl = supabase.storage
          .from('user_pic')
          .getPublicUrl('image/$fileName');
         print("Image URL: $imageUrl");
      //upadate users table
      final response=await supabase
          .from('users')
          .update({
        'profilepic': imageUrl,
      }).eq('id', user.id).select();
      print("Update result: $response");
      _image = imageUrl;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> pickImage(ImageSource source) async{
    final ImagePicker _imagepicker =ImagePicker();
    XFile? _file= await _imagepicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }
    notifyListeners();
  }

  Future<void> selectImage() async {
    final Uint8List? pickedImage = await pickImage(ImageSource.gallery);
    if (pickedImage != null) {
      _img = pickedImage;
      await uploadImageToSupabase(pickedImage);
      notifyListeners();
    }
  }



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
      _image=data['image'];
      // await _storage.write(
      //   key: "image",
      //   value: _image,
      // );
      _data=data;
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
      // _storage.read(key: 'image'),
      // _storage.read(key: 'galleryImage'),
    ]);
    _accessToken = response[0];
    _refreshToken = response[1];
    // _image = response[2];
    // if (response[3] != null) {
    //   _img = base64Decode(response[3]!);
    // }

    notifyListeners();
  }

  Future<void> clearSession() async {
    _accessToken = null;
    _refreshToken = null;
    _img=null;
    _image=null;
    await Future.wait([
      _storage.delete(key: 'accessToken'),
      _storage.delete(key: 'refreshToken'),
      // _storage.delete(key: 'image'),
      // _storage.delete(key: 'galleryImage'),
    ]);
    notifyListeners();
  }


  Future<void> getCurrentUser()async{
    final response=await get(Uri.parse("https://dummyjson.com/auth/me"),
      headers: {
      'Authorization':'Bearer $_accessToken'},
    );
    if(response.statusCode==200){
      final data =jsonDecode(response.body);
      _data=data;
      _image = data["image"];
      notifyListeners();
    }else{
      await clearSession();
    }
  }

  // Future<void> saveUserData(Map<String, dynamic> user) async {
  //   const storage = FlutterSecureStorage();
  //
  //   await storage.write(
  //     key: "user",
  //     value: jsonEncode(user),
  //   );
  // }
  //
  // Map<String, dynamic> user = {};
  //
  // Future<void> loadUserData() async {
  //   const storage = FlutterSecureStorage();
  //
  //   final value = await storage.read(key: "user");
  //
  //   if (value != null) {
  //     user = jsonDecode(value);
  //   }
  //
  //   notifyListeners();
  // }
}




