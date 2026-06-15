import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/task_providers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_app/resources/custom.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:task_app/screens/addtask_screen.dart';
import 'package:task_app/screens/taskupdate_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Hi,User!\nTodays task list'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                spacing: 5,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(
                      "https://thumbs.dreamstime.com/b/empty-tomb-dark-cave-bright-light-stone-slab-candle-religious-easter-concept-resurrection-image-ai-generated-416471218.jpg?w=992",
                    ),
                  ),
                  Text("Prasuna Dahal"),
                  Text("prasunadahal909@gmail.com"),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings, size: 32, color: Color(0xFFA8E6C1)),
              title: Text("Settings"),
              //subtitle: Text("You can change settings"),
            ),
            ListTile(
              leading: Icon(Icons.sunny, size: 32, color:Color(0xFFA8E6C1)),
              title: Text("Theme"),
             // subtitle: Text("You can change theme"),
            ),
            ListTile(
              leading: Icon(Icons.more, size: 32, color:Color(0xFFA8E6C1)),
              title: Text("More"),
              //subtitle: Text("More details"),
            ),
          ],
        ),
      ),
      body: Consumer<TaskProvider>(
        builder:(context,p,_){
          return Container(
            margin: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                DatePicker(
                  daysCount:30,
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor:Color(0xFFA8E6C1),
                  selectedTextColor: Colors.black,

                ),
                SizedBox(height: 20),
                TextFormField(onChanged:(value){
                  p.updateSearch(value);
                },
                  decoration:InputDecoration(
                    hintText:'Search',prefixIcon: Icon(Icons.search),
                    fillColor: Colors.black,border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),),
                SizedBox(height:10),
                Expanded(
                  child: ListView.builder(
                    itemCount:p.filteredLists.length,
                    itemBuilder:(context,index){
                      return Slidable(
                        endActionPane: ActionPane(
                            motion:StretchMotion(),
                            children: [
                              SlidableAction(onPressed:(_){
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text('Edit Task'),
                                    content:Column(
                                      children: [
                                        TextFormField(controller: p.controller,
                                          decoration: InputDecoration(
                                              hintText: 'Title'
                                          ),
                                          textAlign: TextAlign.center,
                                          autofocus: true,
                                        ),
                                        TextFormField(controller: p.descriptioncontroller,
                                          decoration: InputDecoration(
                                              hintText:'Description'
                                          ),
                                          textAlign: TextAlign.center,
                                          autofocus: true,
                                        ),
                                        TextFormField(controller: p.datecontroller,
                                          decoration:InputDecoration(
                                            labelText: 'Select Date',
                                            suffixIcon: Icon(Icons.calendar_today_rounded,),
                                            //hintText:'Time'
                                          ),
                                          onTap: () async {
                                            p.pickDate(context);
                                          },
                                          textAlign: TextAlign.center,
                                          autofocus: true,
                                        ),
                                        TextFormField(controller: p.startTimeController,
                                          decoration:InputDecoration(
                                            labelText: 'Start Time',
                                          ),
                                          onTap: () async {
                                            p.pickStartTime(context);
                                          },
                                          textAlign: TextAlign.center,
                                          autofocus: true,
                                        ),
                                        TextFormField(controller: p.endTimeController,
                                          decoration:InputDecoration(
                                            labelText: 'End Time',
                                          ),
                                          onTap: () async {
                                            p.pickEndTime(context);
                                          },
                                          textAlign: TextAlign.center,
                                          autofocus: true,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      CustomElevatedButton(onPressed:()async{
                                        p.editTask(index);
                                        Navigator.pop(context);
                                      },
                                          widget:Text('Edit'))
                                    ],
                                  );
                                });
                              },
                                backgroundColor: Color(0xFF7E57C2),
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(onPressed:(_){
                                p.deleteTask(index);
                              },backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Delete',
                              )
                            ]),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text(p.filteredLists[index]['title']),
                                  Text(p.filteredLists[index]['date']),
                                ],
                              ),
                              Text(p.filteredLists[index]['description']),
                              Text(p.filteredLists[index]['startTime']),
                              Text(p.filteredLists[index]['endTime']),
                              Text(p.filteredLists[index]['category']),
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

