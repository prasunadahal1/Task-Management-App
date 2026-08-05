import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/admin_provider/admin_dashboard_provider.dart';
import 'package:task_app/resources/colors.dart';
import '../Routes/Admin_Routes/admin_route.dart';
import '../providers/user_provider/session_management.dart';
import '../user_screen/profile_screen.dart';
import 'admin_profile.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late final AdminDashboardProvider provider = Provider.of<AdminDashboardProvider>(context,listen: false);
  late SessionManagement sessionManagement = Provider.of<SessionManagement>(
    context,
    listen: false,
  );
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SessionManagement>(
        context,
        listen: false,
      ).getUserData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF7F5EE),
    body:CustomScrollView(
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
               onTap:(){
                 // Navigator.push(
                 //   context,
                 //   MaterialPageRoute(builder: (context) => AdminProfile()),
                 // );
                 Navigator.pushNamed(context, Routes.adminProfileScreen);
               },
               child: CircleAvatar(
                 backgroundImage: sessionManagement.img != null
                     ? MemoryImage(sessionManagement.img!)
                     : sessionManagement.image != null
                     ? NetworkImage(sessionManagement.image!)
                     : NetworkImage(
                   'https://img.magnific.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3467.jpg?semt=ais_hybrid&w=740&q=80',
                 ),
                 // backgroundImage:sessionProvider.image!=null? MemoryImage(sessionProvider.image! as Uint8List):NetworkImage('https://img.magnific.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3467.jpg?semt=ais_hybrid&w=740&q=80'),
                 backgroundColor: Color(0xFF84C5A5),
                 radius: 20,
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
                sessionManagement.userName??"",
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
              IconButton(onPressed: (){
                provider.toggleTheme();
              }, icon:Icon(
                  provider.isDarkMode? Icons.light_mode:Icons.dark_mode,
              )),
              SizedBox(width: 15),
              Icon(Icons.notifications_none),
              SizedBox(width:20),
            ]
       ),
        SliverToBoxAdapter(
          child: SizedBox(height:5),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:16),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    "Total Employee",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height:5),
                  Text(
                    "20",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4B5D1A),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:12),
            child: GridView.builder(
              shrinkWrap: true,
              physics:  NeverScrollableScrollPhysics(),
              itemCount: provider.overview.length,
              gridDelegate:
               SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height*0.9,
                  padding:  EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(provider.overview[index]['icon']),
                      SizedBox(height:3),
                      Text(
                      '${provider.overview[index]["count"]}-${provider.overview[index]["title"]}',
                        style:  TextStyle(
                          fontSize:20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4B5D1A),
                        ),
                      ),
                       SizedBox(height:3),
                      Text(
                        provider.overview[index]["subtitle"],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:12),
            child: GridView.builder(
              shrinkWrap: true,
              physics:  NeverScrollableScrollPhysics(),
              itemCount: provider.overview1.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height*0.9,
                  padding:  EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(provider.overview1[index]['icon']),
                      SizedBox(height:3),
                      Text(
                        '${provider.overview1[index]["count"]}-${provider.overview1[index]["title"]}',
                        style:  TextStyle(
                          fontSize:20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4B5D1A),
                        ),
                      ),
                      SizedBox(height:3),
                      Text(
                        provider.overview1[index]["subtitle"],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
         SliverToBoxAdapter(
          child: SizedBox(height: 22),
        ),
         SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "All Assigned Tasks",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 18),
            child: ListView.builder(
              itemCount: provider.projectList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final project = provider.projectList[index];
                return Container(
                  margin:  EdgeInsets.only(bottom: 14),
                  padding:  EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              project['Title']??"",
                              style:  TextStyle(
                                fontWeight:
                                FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),

                          Container(
                            padding:
                             EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius:
                              BorderRadius.circular(
                                  20),
                            ),
                            child: Text(
                              project["Priority"]??"",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.green,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            )
                          ),
                          Text(project["Description"]??""),
                        ],
                      ),

                      SizedBox(height: 14),

                      Row(
                        children: [
                          //  CircleAvatar(
                          //   radius: 13,
                          //   backgroundImage:
                          //   NetworkImage(
                          //       "https://img.magnific.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3467.jpg?semt=ais_hybrid&w=740&q=80"),
                          // ),
                           SizedBox(width: 8),
                          Text(project["Assign To"]??""),
                          Spacer(),
                          Container(
                            padding:
                             EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius:
                              BorderRadius.circular(
                                  20),
                            ),
                            child: Text(
                              project["Status"]??"",
                              style:  TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                           SizedBox(width: 10),
                          Text(
                            project["Due Date"]??"",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    )
    );
  }
}
