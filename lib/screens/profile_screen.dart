import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/task_providers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: SingleChildScrollView(
        child: Consumer<TaskProvider>(
          builder: (context,p,_){
            return Column(
            children: [
            SizedBox(height: 30),
            Stack(
              children: [
                CircleAvatar(
                  radius:65,backgroundImage:p.image!=null? MemoryImage(p.image!):NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP2PkyoMJU2a4Ye6rIxeKgVFMonYPnIwIGLJMXJ6lrVrhJzmxd3IrBu22N&s=10'),
                ),
                Positioned(child:IconButton(
                  onPressed: (){
                    p.selectImage();
                  }, icon:Icon(Icons.add_a_photo,size:25),
                ),
                  bottom:-9,
                  left: 70,
                ),
              ],
            ),
              // TextButton(
              //   onPressed: () {
              //     p.selectImage();
              //   },
              //   child:Row(
              //     mainAxisAlignment: .center,
              //     children: [
              //       Text("Add Photo",style: TextStyle(color: Colors.grey.shade600),),
              //       Icon(Icons.add_a_photo_outlined,color: Colors.grey.shade600,)
              //     ],
              //   ),
              // ),
            SizedBox(height:5),
            Text(
            "Prasuna Dahal",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height:3),

            Text(
            "prasunadahal@gmail.com",
            style: TextStyle(color: Colors.grey.shade600),
            ),

            SizedBox(height: 30),

            Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
            leading: Icon(Icons.person_outline),
            title: Text("Edit Profile"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
            ),
            ),

            Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
            leading: Icon(Icons.notifications_outlined),
            title: Text("Notifications"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
            ),
            ),

            Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text("Privacy"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
            ),
            ),

            Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text("Settings"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
            ),
            ),

            SizedBox(height: 30),

            // ElevatedButton.icon(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon:  Icon(Icons.logout),
            //   label:  Text("Logout"),
            // ),
            ],
            );
          },
        ),
      ),
    );
  }
}

