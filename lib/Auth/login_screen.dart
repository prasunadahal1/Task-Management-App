import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/resources/main_screen.dart';

import '../providers/user_provider/session_management.dart';
import '../user_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final SessionManagement sessionProvider = Provider.of<SessionManagement>(context,listen: false);

  // @override
  // void dispose() {
  //   sessionProvider.namecontroller.dispose();
  //   sessionProvider.passwordcontroller.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30),

              TextFormField(
                controller: sessionProvider.namecontroller,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: sessionProvider.passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    sessionProvider.postData(sessionProvider.namecontroller.text, sessionProvider.passwordcontroller.text,context);
                    // final session=SessionManagement.instance;
                    // session.setSession(sessionProvider.namecontroller.text,sessionProvider.passwordcontroller.text);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MainScreen(),
                    //   ),
                    // );
                  },
                  child: Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
