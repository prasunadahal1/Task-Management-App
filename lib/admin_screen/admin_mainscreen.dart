import 'package:flutter/material.dart';
import 'package:task_app/admin_screen/admin_approvaltask.dart';
import 'package:task_app/admin_screen/admin_createtask.dart';
import 'package:task_app/admin_screen/admin_dashboard.dart';
import '../resources/colors.dart';

class AdminMainscreen extends StatefulWidget {
  const AdminMainscreen({super.key});

  @override
  State<AdminMainscreen> createState() => _AdminMainscreenState();
}

class _AdminMainscreenState extends State<AdminMainscreen> {
  final List<Widget> page=[
    AdminDashboard(),
    AdminApprovalTask()
  ];
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:ClipRRect(
        borderRadius:BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomAppBar(
          height: 63,
          shape:CircularNotchedRectangle(),
          notchMargin:5,
          color: CustomColors.navigation(context),
          child: SizedBox(height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  _buildNavItem(
                    icon: Icons.home,
                    index: 0,
                  ),
                  SizedBox(width: 40),
                  _buildNavItem(
                    icon: Icons.assignment,
                    index: 1,
                  ),
                ]
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color:Color(0xFF84C5A5).withOpacity(0.4),
              blurRadius:12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(backgroundColor: Colors.white,elevation: 0,shape:CircleBorder(side: BorderSide(width: 3,color: CustomColors.floating(context))),
          child: Icon(Icons.add_rounded,color: CustomColors.floatingicon(context),),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (_){
                  return AdminCreateTask();
                }
                ));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: page[currentIndex],
    );
  }
  Widget _buildNavItem({
    required IconData icon,
    required int index,
  }) {
    bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration:  Duration(milliseconds: 250),
        padding:  EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: selected
            ? BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        )
            : null,
        child: Icon(
          icon,
          color: selected ? Colors.black : Colors.grey,
          size: 25,
        ),
      ),
    );
  }
}
