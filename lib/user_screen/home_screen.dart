import 'dart:typed_data';

import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_app/resources/colors.dart';
import 'package:task_app/providers/user_provider/task_providers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_app/resources/custom.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:task_app/user_screen/addtask_screen.dart';
import 'package:task_app/user_screen/profile_screen.dart';
import 'package:task_app/user_screen/taskupdate_screen.dart';

import '../providers/user_provider/task_providers.dart';
import '../providers/user_provider/session_management.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase =Supabase.instance.client;
  late SessionManagement sessionManagement = Provider.of<SessionManagement>(
    context,
    listen: false,

  );
  @override
  void initState() {
    final TaskProvider taskProvider = Provider.of<TaskProvider>(
      context,
      listen: false,
    );
    super.initState();
    Future.microtask(() {
      Provider.of<SessionManagement>(
        context,
        listen: false,
      ).getUserData();
    });
    taskProvider.getData();
    taskProvider.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor(context),
      appBar: AppBar(
        elevation: 0.5,
        shadowColor: Colors.black.withOpacity(0.4),
        backgroundColor: CustomColors.appbar(context),
        title: Column(
          children: [
            SizedBox(height: 13),
        Text(sessionManagement.userName??"",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.blacktext(context),
                    fontSize: 20,
                  ),
                ),
            // FutureBuilder(
            //     future: supabase.from('users').select().eq('id', supabase.auth.currentUser!.id).single(),
            //     builder: (context,snapshot){
            //       if (snapshot.connectionState==ConnectionState.waiting){
            //       }
            //       final user=snapshot.data??{};
            //       return  Text(user['name']??"",
            //         style: TextStyle(
            //           fontWeight: FontWeight.w500,
            //           color: CustomColors.blacktext(context),
            //           fontSize: 20,
            //         ),
            //       );
            //     }),
            Text(
              'Have a nice day!',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: CustomColors.greytext(context),
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
        actions: [
          Consumer<TaskProvider>(
            builder: (context, provider, _) {
              return IconButton(
                onPressed: () {
                  provider.toggleTheme();
                },
                icon: Icon(
                  provider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
              );
            },
          ),
          SizedBox(width: 15),
          Padding(
            padding: EdgeInsetsGeometry.only(right: 15),
            child: Consumer<SessionManagement>(
              builder: (context, sessionProvider, _) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: sessionProvider.img != null
                        ? MemoryImage(sessionProvider.img!)
                        : sessionProvider.image != null
                        ? NetworkImage(sessionProvider.image!)
                        : NetworkImage(
                            'https://img.magnific.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3467.jpg?semt=ais_hybrid&w=740&q=80',
                          ),
                    // backgroundImage:sessionProvider.image!=null? MemoryImage(sessionProvider.image! as Uint8List):NetworkImage('https://img.magnific.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3467.jpg?semt=ais_hybrid&w=740&q=80'),
                    backgroundColor: Color(0xFF84C5A5),
                    radius: 20,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, p, _) {
          return Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: CustomColors.card(context),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: CustomColors.cardborder(context),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DatePicker(
                    daysCount: 30,
                    DateTime.now(),
                    height: 100,
                    width: 80,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Color(0xFF84C5A5),
                    selectedTextColor: Colors.black,
                    deactivatedColor: Color(0xFFB0B0B0),
                  ),
                ),
                SizedBox(height: 20),

                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: TextFormField(
                    onChanged: (value) {
                      p.searchFilter(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          color: Color(0xFF84C5A5),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          color: Color(0xFF84C5A5),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: p.filteredLists.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                p.initEditTask(
                                  title: p.filteredLists[index]['title'] ?? '',
                                  desc:
                                      p.filteredLists[index]['description'] ??
                                      '',
                                  date: p.filteredLists[index]['date'] ?? '',
                                  startTime:
                                      p.filteredLists[index]['startTime'] ?? '',
                                  endTime:
                                      p.filteredLists[index]['endTime'] ?? '',
                                  category:
                                      p.filteredLists[index]['category'] ?? '',
                                );
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(20),
                                      ),
                                      title: Text(
                                        'Edit Task',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: p.controller,
                                              decoration: InputDecoration(
                                                labelText: 'Title',
                                                prefixIcon: Icon(Icons.title),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              autofocus: true,
                                            ),
                                            SizedBox(height: 15),
                                            TextFormField(
                                              controller:
                                                  p.descriptioncontroller,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.description,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                labelText: 'Description',
                                              ),
                                              autofocus: true,
                                            ),
                                            SizedBox(height: 15),
                                            TextFormField(
                                              controller: p.datecontroller,
                                              decoration: InputDecoration(
                                                labelText: 'Select Date',
                                                suffixIcon: Icon(
                                                  Icons.calendar_today_rounded,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                //hintText:'Time'
                                              ),
                                              onTap: () async {
                                                p.pickDate(context);
                                              },
                                              autofocus: true,
                                            ),
                                            SizedBox(height: 15),
                                            TextFormField(
                                              controller: p.startTimeController,
                                              decoration: InputDecoration(
                                                labelText: 'Start Time',
                                                prefixIcon: Icon(
                                                  Icons.access_time,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onTap: () async {
                                                p.pickStartTime(context);
                                              },
                                              autofocus: true,
                                            ),
                                            SizedBox(height: 15),
                                            TextFormField(
                                              controller: p.endTimeController,
                                              decoration: InputDecoration(
                                                labelText: 'End Time',
                                                prefixIcon: Icon(
                                                  Icons.schedule,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onTap: () async {
                                                p.pickEndTime(context);
                                              },
                                              autofocus: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        CustomElevatedButton(
                                          onPressed: () async {
                                            p.clearControllers();
                                            Navigator.pop(context);
                                          },
                                          widget: Text('cancel'),
                                        ),
                                        CustomElevatedButton(
                                          onPressed: () async {
                                            final taskId = p
                                                .filteredLists[index]['id']
                                                ?.toString();
                                            if (taskId == null) return;

                                            p.editTask(index);
                                            final success = await p.editData(
                                              p.controller.text,
                                              p.descriptioncontroller.text,
                                              p.datecontroller.text,
                                              p.startTimeController.text,
                                              p.endTimeController.text,
                                              p.categorycontroller.text,
                                              taskId,
                                            );
                                            if (!context.mounted) return;

                                            p.clearControllers();
                                            Navigator.pop(context);

                                            if (success) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.white,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                  bottom:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.height -
                                                      180,
                                                  left: 16,
                                                  right: 16,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        15,
                                                      ),
                                                ),
                                                content: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: Color(0xFF84C5A5),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      'Edited Task Successfully',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                            }
                                          },
                                          widget: Text('Edit'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              backgroundColor: CustomColors.editdeletepanel(
                                context,
                              ),
                              icon: Icons.edit,
                              foregroundColor: Color(0xFF84C5A5),
                              label: 'Edit',
                            ),
                            SlidableAction(
                              onPressed: (_) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Text(
                                        'Are you sure you want to delete?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                              color: Color(0xFF84C5A5),
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                              color: Color(0xFF84C5A5),
                                            ),
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            print(p.filteredLists[index]["id"]);
                                            p.deleteData(
                                              p.filteredLists[index]["id"]
                                                  .toString(),
                                            );
                                            // p.deleteTask(index);
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.white,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                  bottom:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.height -
                                                      180,
                                                  left: 16,
                                                  right: 16,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        15,
                                                      ),
                                                ),
                                                content: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: Color(0xFF84C5A5),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      'Deleted Task Sucessfully',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                              color: Color(0xFF84C5A5),
                                            ),
                                          ),
                                        ),
                                        // TextButton(onPressed: (){
                                        //   Navigator.pop(context);
                                        // }, child:Text('No',style: TextStyle(color: Color(0xFF84C5A5)),)),
                                        // TextButton(onPressed: (){
                                        //   p.deleteTask(index);
                                        //   Navigator.pop(context);
                                        // }, child:Text('Yes',style: TextStyle(color: Colors.red),)),
                                      ],
                                    );
                                  },
                                );
                              },
                              backgroundColor: CustomColors.editdeletepanel(
                                context,
                              ),
                              icon: Icons.delete,
                              foregroundColor: Colors.red,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CustomColors.cardborder(context),
                            ),
                            color: CustomColors.card(context),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF84C5A5),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.task,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: .start,
                                      children: [
                                        Text(
                                          p.filteredLists[index]['title'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            // color: CustomColors.blacktext(context),
                                          ),
                                        ),
                                        Text(
                                          p.filteredLists[index]['description'],
                                          style: TextStyle(
                                            color: CustomColors.greytext(
                                              context,
                                            ),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          '${p.filteredLists[index]['startTime']}-${p.filteredLists[index]['endTime']}',
                                          style: TextStyle(
                                            color: CustomColors.greytext(
                                              context,
                                            ),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          p.filteredLists[index]['category'],
                                          style: TextStyle(
                                            color: CustomColors.greytext(
                                              context,
                                            ),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    p.filteredLists[index]['date'],
                                    style: TextStyle(
                                      color: CustomColors.greytext(context),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
