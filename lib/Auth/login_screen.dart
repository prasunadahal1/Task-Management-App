import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/Auth/signup_screen.dart';
import 'package:task_app/user_screen/main_screen.dart';

import '../providers/user_provider/session_management.dart';
import '../user_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final SessionManagement sessionProvider = Provider.of<SessionManagement>(context,listen: false);
  bool hidePassword=true;

  // @override
  // void dispose() {
  //   sessionProvider.namecontroller.dispose();
  //   sessionProvider.emailcontroller.dispose();
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
                controller: sessionProvider.emailcontroller,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: sessionProvider.passwordcontroller,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
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
                    sessionProvider.login(context);
                    // sessionProvider.postData(sessionProvider.emailcontroller.text, sessionProvider.passwordcontroller.text,context);
                  },
                  child: Text('Login'),
                ),
              ),
              SizedBox(height: 30),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
              },
                  child: Text("Don't have an account? SignUp"))
            ],
          ),
        ),
      ),
    );
  }
}
