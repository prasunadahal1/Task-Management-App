import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/user_provider/task_providers.dart';


import '../resources/colors.dart';
import '../resources/custom.dart';
import 'home_screen.dart';

class TaskupdateScreen extends StatefulWidget {
  const TaskupdateScreen({super.key});

  @override
  State<TaskupdateScreen> createState() => _TaskupdateScreenState();
}

class _TaskupdateScreenState extends State<TaskupdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        }, icon: Icon(Icons.arrow_back_ios),color:CustomColors.appbararrowicon(context)),
        title: Text('My Tasks'),
      ),
      body: Consumer<TaskProvider>(
        builder:(context,p,_){
          return  Container(
            child :Expanded(
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
                                        p.editTask(index);
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                backgroundColor: Colors.white,
                                                behavior: SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 180,left: 16,right: 16),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                                                content: Row(
                                                  children: [
                                                    Icon(Icons.check_circle, color: Color(0xFF84C5A5)),
                                                    SizedBox(width: 10),
                                                    Text('Edited Task Sucessfully',style: TextStyle(color:Colors.black),),
                                                  ],
                                                )));
                                      },
                                      widget: Text('Edit'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          backgroundColor: CustomColors.editdeletepanel(context),
                          icon: Icons.edit,
                          foregroundColor: Color(0xFF84C5A5),
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: (_) {
                            showDialog(context: context, builder:(context){
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text('Are you sure you want to delete?',textAlign:TextAlign.center,style: TextStyle(fontSize:20),),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text('No',style: TextStyle(color: Color(0xFF84C5A5)),),style:OutlinedButton.styleFrom(side: BorderSide(color: Color(0xFF84C5A5))),),
                                  OutlinedButton(
                                      onPressed: () {
                                        p.deleteTask(index);
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                backgroundColor: Colors.white,
                                                behavior: SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 180,left: 16,right: 16),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                                                content: Row(
                                                  children: [
                                                    Icon(Icons.check_circle, color: Color(0xFF84C5A5)),
                                                    SizedBox(width: 10),
                                                    Text('Deleted Task Sucessfully',style: TextStyle(color:Colors.black),),
                                                  ],
                                                )));
                                      }, child: Text('Yes',style: TextStyle(color: Colors.red),),style:OutlinedButton.styleFrom(side: BorderSide(color: Color(0xFF84C5A5)))),
                                  // TextButton(onPressed: (){
                                  //   Navigator.pop(context);
                                  // }, child:Text('No',style: TextStyle(color: Color(0xFF84C5A5)),)),
                                  // TextButton(onPressed: (){
                                  //   p.deleteTask(index);
                                  //   Navigator.pop(context);
                                  // }, child:Text('Yes',style: TextStyle(color: Colors.red),)),
                                ],
                              );
                            });
                          },
                          backgroundColor: CustomColors.editdeletepanel(context),
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
                        border: Border.all(color: CustomColors.cardborder(context)),
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
                                        color: CustomColors.greytext(context),
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      '${p.filteredLists[index]['startTime']}-${p.filteredLists[index]['endTime']}',
                                      style: TextStyle(
                                        color: CustomColors.greytext(context),
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      p.filteredLists[index]['category'],
                                      style: TextStyle(
                                        color: CustomColors.greytext(context),
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
          );
        }

      ),
    );
  }
}
