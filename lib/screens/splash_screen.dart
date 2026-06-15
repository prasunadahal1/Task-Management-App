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
      backgroundColor:Color(0xFFE2F8EC),
      body: Container(
        child: Column(
          // mainAxisAlignment:.center,
          // crossAxisAlignment: .center,
          spacing:5,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.35,width: MediaQuery.of(context).size.width * 0.75,
                margin: EdgeInsets.only(left:75,top: 140),
                child: Image.asset("assets/home.png-removebg-preview.png",fit: BoxFit.cover,)
            ),
             Column(
               children: [
                 Text("Keep It All In\nOne Place", textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                 ),
                 SizedBox(height:5),
                 Text("Organize your tasks and boost \n your productivity every day.", textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 16,
                     color: Colors.grey.shade700,
                     height: 1.6,
                   ),
                 ),
                 SizedBox(height:18),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       width: 25,
                       height: 8,
                       decoration: BoxDecoration(
                         color: Color(0xFFA8E6C1),
                         borderRadius: BorderRadius.circular(10),
                       ),
                     ),
                     SizedBox(width: 6),
                     CircleAvatar(
                       radius: 4,
                       backgroundColor: Colors.grey.shade300,
                     ),
                     SizedBox(width: 6),
                     CircleAvatar(
                       radius: 4,
                       backgroundColor: Colors.grey.shade300,
                     ),
                   ],
                 ),
               ],
             ),

            // Container(
            //   padding:EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //       color: Colors.white.withOpacity(0.3),
            //     //color: Color(0xFFE2F8EC),
            //     borderRadius: BorderRadius.circular(16),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Column(
            //         children: [
            //           Text("50+"),
            //           Text("Tasks"),
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           Text("24/7"),
            //           Text("Access"),
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           Text("100%"),
            //           Text("Free"),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height:130),
            Row(
              mainAxisAlignment:.center,
              children: [
                CustomElevatedButton(backgroundColor:Color(0xFFA8E6C1),width:0.9,height:58,borderRadius:15,
                    onPressed:()async{
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_){
                          return MainScreen();
                        }
                        ));
                },
                  widget: Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text('Get Start',style: TextStyle(fontSize: 18, color: Colors.white,),),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,size:30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(width:4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
