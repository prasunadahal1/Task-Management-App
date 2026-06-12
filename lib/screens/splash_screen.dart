import 'package:flutter/material.dart';
import 'package:task_app/resources/main_screen.dart';
import 'package:task_app/resources/custom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          //color: Colors.white,
          margin: EdgeInsets.only(top:180),
          child: Column(
            spacing: 120,
            children: [
              Image(image: AssetImage('assets/home.png'),),
              Row(
                mainAxisAlignment: .end,
                children: [
                  CustomElevatedButton(backgroundColor:Color(0xffAEDBC6),width: 0.4,height:45,
                      onPressed:()async{
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_){
                            return MainScreen();
                          }
                          ));
                  }, widget: Text('Get Started')),
                  SizedBox(width: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
