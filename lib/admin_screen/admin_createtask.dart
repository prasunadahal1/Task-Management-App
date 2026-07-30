import 'package:flutter/material.dart';

class AdminCreateTask extends StatefulWidget {
  const AdminCreateTask({super.key});

  @override
  State<AdminCreateTask> createState() => _AdminCreateTaskState();
}

class _AdminCreateTaskState extends State<AdminCreateTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F5EE),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              // backgroundColor:CustomColors.appbar(context),
              backgroundColor: const Color(0xffF7F5EE),
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight:90,
              title: Row(
                  children: [
                    GestureDetector(
                      onTap:(){},
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage:
                        NetworkImage("https://img.magnific.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3467.jpg?semt=ais_hybrid&w=740&q=80"),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(
                          "Hello,Admin",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Prasuna Dahal",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
              actions:[
                SizedBox(width: 15),
                Icon(Icons.notifications_none),
                SizedBox(width:20),
              ]
          ),
        ],
      ),
    );
  }
}
