import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_app/providers/user_provider/task_providers.dart';
import 'package:task_app/user_screen/splash_screen.dart';

import '../providers/user_provider/session_management.dart';
import '../resources/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final supabase=Supabase.instance.client;
  late SessionManagement sessionManagement = Provider.of<SessionManagement>(
    context,
    listen: false,

  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: SingleChildScrollView(
        child: Consumer<SessionManagement>(
          builder: (context, p, _) {
            return Column(
              children: [
                SizedBox(height: 30),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      // backgroundImage: NetworkImage(sessionProvider.image!),
                      backgroundImage: p.img != null
                          ? MemoryImage(p.img!)
                          : p.image != null
                          ? NetworkImage(p.image!)
                          : NetworkImage(
                              'https://img.magnific.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3467.jpg?semt=ais_hybrid&w=740&q=80',
                            ),
                    ),
                    Positioned(
                      child: IconButton(
                        onPressed: () {
                          p.selectImage();
                        },
                        icon: Icon(Icons.add_a_photo, size: 25),
                      ),
                      bottom: -9,
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
                SizedBox(height: 5),
            Text(sessionManagement.userName??"",
            style: TextStyle(
            fontWeight: FontWeight.w500,
            color: CustomColors.blacktext(context),
            fontSize: 20,
            ),
            ),

                SizedBox(height: 3),
            Text(sessionManagement.email??"",
            style: TextStyle(
            fontWeight: FontWeight.w500,
            color: CustomColors.blacktext(context),
            fontSize: 20,
            ),
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
                    title: Text("Logout"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () async{
                      await supabase.auth.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                        (route) => false,
                      );
                    },
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
