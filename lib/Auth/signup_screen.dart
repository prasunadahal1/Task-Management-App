import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/Auth/login_screen.dart';

import '../providers/user_provider/session_management.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final SessionManagement sessionProvider = Provider.of<SessionManagement>(context,listen: false);
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
                'SignUp',
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
                    sessionProvider.register(context);
                    // sessionProvider.postData(sessionProvider.emailcontroller.text, sessionProvider.passwordcontroller.text,context);
                  },
                  child: Text('SignUp'),
                ),
              ),
              SizedBox(height: 30),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
                  child: Text("Already have an account? Login"))
            ],
          ),
        ),
      ),
    );
  }
}
