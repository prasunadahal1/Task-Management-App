import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/admin_provider/admin_dashboard_provider.dart';
import 'package:task_app/providers/user_provider/task_providers.dart';

import '../providers/user_provider/session_management.dart';
import '../resources/colors.dart';
import '../resources/custom.dart';

class AdminCreateTask extends StatefulWidget {
  const AdminCreateTask({super.key});

  @override
  State<AdminCreateTask> createState() => _AdminCreateTaskState();
}

class _AdminCreateTaskState extends State<AdminCreateTask> {
  late SessionManagement sessionManagement = Provider.of<SessionManagement>(
    context,
    listen: false,
  );
  late AdminDashboardProvider provider = Provider.of<AdminDashboardProvider>(
    context,
    listen: false,
  );
  late TaskProvider p = Provider.of<TaskProvider>(
    context,
    listen: false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.addtaskprimarygreen(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              backgroundColor:CustomColors.appbar(context),
              // backgroundColor: const Color(0xffF7F5EE),
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
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Assign New Task",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  decoration: BoxDecoration(
                    color: CustomColors.addtaskprimarygreen(context),
                    borderRadius: BorderRadius.only(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        textAlignVertical: TextAlignVertical(y: 0.5),
                        controller: p.controller,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                      Divider(color: CustomColors.addtaskdivider(context)),
                      TextFormField(
                        controller: p.descriptioncontroller,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                      Divider(color: CustomColors.addtaskdivider(context)),
                      TextFormField(
                        controller: p.datecontroller,
                        decoration: InputDecoration(
                          labelText: 'Due Date',
                          labelStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () async {
                          p.pickDate(context);
                        },
                      ),
                      Divider(color: CustomColors.addtaskdivider(context)),
                    ],
                  ),
                ),
                SizedBox(height:10),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Consumer<AdminDashboardProvider>(
                    builder: (context, provider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Row(
                            children: [
                              Icon(Icons.person_outline),
                              SizedBox(width: 8),
                              Text(
                                "Assign To",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                           SizedBox(height: 10),

                          Container(
                            padding:  EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Map<String, dynamic>>(
                                isExpanded: true,
                                hint:  Text("Select Employee"),
                                value: provider.selectedEmployee,
                                items: provider.employees.map((employee) {
                                  return DropdownMenuItem<Map<String, dynamic>>(
                                    value: employee,
                                    child: Text(
                                      "${employee["name"]} (${employee["role"]})",
                                      style:  TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: provider.changeEmployee,
                              ),
                            ),
                          ),

                           SizedBox(height: 25),


                           Row(
                            children: [
                              Icon(Icons.sync_alt),
                              SizedBox(width: 8),
                              Text(
                                "Status",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                           SizedBox(height: 10),

                          Container(
                            padding:  EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Map<String, dynamic>>(
                                isExpanded: true,
                                value: provider.selectedStatus,
                                items: provider.statusList.map((status) {
                                  return DropdownMenuItem<Map<String, dynamic>>(
                                    value: status,
                                    child: Text(status["status"]),
                                  );
                                }).toList(),
                                onChanged: provider.changeStatus,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.cardborder(context)),
                    color: CustomColors.addtaskcategory(context),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Priority Level",
                            style: TextStyle(
                              color: CustomColors.blacktext(context),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            Container(
                              height:42,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: p.category.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      SizedBox(width:8),
                                      ChoiceChip(
                                        shape: RoundedSuperellipseBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        backgroundColor: p.category[index]['isSelected']
                                            ? CustomColors.addtaskprimarygreen(context)
                                            : Color(0xFFEAFBF0),
                                        label: Text(
                                          p.category[index]['title'],
                                          style: TextStyle(
                                            color: p.category[index]['isSelected']
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        selected:p.category[index]['isSelected'],
                                        onSelected: (value) {
                                          p.chip(index, value);
                                          print(p.title);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:80),
                        CustomElevatedButton(
                          backgroundColor: Color(0xFF84C5A5),
                          width: 30,
                          height: 50,
                          borderRadius: 15,
                          onPressed: () async {
                            if (p.controller.text.trim().isNotEmpty) {
                              await context.read<TaskProvider>().addTask(
                                p.controller.text.trim(),
                                p.descriptioncontroller.text.trim(),
                                p.datecontroller.text.trim(),
                                p.startTimeController.text.trim(),
                                p.endTimeController.text.trim(),
                                p.title!,
                                context,
                              );
                              p.controllerclear();
                            }
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(
                                    bottom:
                                    MediaQuery.of(context).size.height - 180,
                                    left: 16,
                                    right: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
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
                                        'Assigned Task Sucessfully',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          },
                          widget: Text('Assign Task'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
