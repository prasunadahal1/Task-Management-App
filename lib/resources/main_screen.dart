import 'package:flutter/material.dart';

import '../screens/addtask_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/taskupdate_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> page=[
    LandingScreen(),
    TaskupdateScreen(),
  ];
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (bottomNavigationBar:NavigationBar(
        backgroundColor:  Color(0xffAEDBC6),
        selectedIndex: currentIndex,
        onDestinationSelected: (index){
          setState(() {
            currentIndex=index;
          });
        },
        //type:BottomNavigationBarType.fixed,
        destinations:[
          NavigationDestination(icon:Icon(Icons.home),label: 'Home'),
          NavigationDestination(icon:Icon(Icons.task),label: 'Task'),
        ]),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (_){
                return AddtaskScreen();
              }
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: page[currentIndex],
    );
  }
}
