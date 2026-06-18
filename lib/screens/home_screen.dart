import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/colors/colors.dart';
import 'package:task_app/providers/task_providers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_app/resources/custom.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:task_app/screens/addtask_screen.dart';
import 'package:task_app/screens/profile_screen.dart';
import 'package:task_app/screens/taskupdate_screen.dart';

import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor(context),
      appBar: AppBar(
        backgroundColor: CustomColors.appbar(context),
        title: Column(
          children: [
            SizedBox(height: 5),
            Text(
              'Hi,User!',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: CustomColors.blacktext(context),
              ),
            ),
            Text(
              'Todays task list',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: CustomColors.greytext(context),
                fontSize: 18,
              ),
            ),
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
            child: Consumer<TaskProvider>(
              builder: (context,p,_){
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: p.image!=null? MemoryImage(p.image!):NetworkImage('https://img.magnific.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3467.jpg?semt=ais_hybrid&w=740&q=80'),
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
            margin: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                DatePicker(
                  daysCount: 30,
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Color(0xFFA8E6C1),
                  selectedTextColor: CustomColors.datepickertext(context),
                  deactivatedColor: Colors.blue,
                ),

                SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    p.searchFilter(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),

                SizedBox(height: 10),
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
                                              textAlign: TextAlign.center,
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
                                              textAlign: TextAlign.center,
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
                                              textAlign: TextAlign.center,
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
                                              textAlign: TextAlign.center,
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
                                              textAlign: TextAlign.center,
                                              autofocus: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        CustomElevatedButton(
                                          onPressed: () async {
                                            p.editTask(index);
                                            p.toastMessageEdit();
                                            Navigator.pop(context);

                                          },
                                          widget: Text('Edit'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              backgroundColor: Color(0xFFECFCF3),
                              icon: Icons.edit,
                              foregroundColor: Color(0xFF84C5A5),
                              label: 'Edit',
                            ),
                            SlidableAction(
                              onPressed: (_) {
                                p.deleteTask(index);
                              },
                              backgroundColor: Color(0xFFECFCF3),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 8,
                                offset: Offset(0, 4),
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
                                          ),
                                        ),
                                        Text(
                                          p.filteredLists[index]['description'],
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          '${p.filteredLists[index]['startTime']}-${p.filteredLists[index]['endTime']}',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          p.filteredLists[index]['category'],
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    p.filteredLists[index]['date'],
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
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
