import 'package:flutter/material.dart';
import 'package:task_app/resources/colors.dart';
import 'package:task_app/providers/user_provider/task_providers.dart';
import 'package:provider/provider.dart';
import 'package:task_app/resources/custom.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_app/user_screen/home_screen.dart';

class AddtaskScreen extends StatefulWidget {
  const AddtaskScreen({super.key});

  @override
  State<AddtaskScreen> createState() => _AddtaskScreenState();
}

class _AddtaskScreenState extends State<AddtaskScreen> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: CustomColors.addtaskprimarygreen(context),
        title: Text('Create New Task', style: TextStyle(color: Colors.white)),
        actions: [
          Icon(Icons.task, color: Colors.white),
          SizedBox(width: 80),
        ],
      ),
      backgroundColor: CustomColors.addtaskprimarygreen(context),
      body: _body2(context),
    );
  }

  // Widget _body(context){
  //   return Consumer<TaskProvider>(
  //       builder:(context,p,_){
  //         return Column(
  //             mainAxisAlignment: .start,
  //             children:[
  //               Container(
  //                 decoration: BoxDecoration(
  //                   color: CustomColors.lightgreen(context),
  //                   borderRadius: BorderRadius.only(),
  //                 ),
  //                 child: Padding(
  //                   padding: EdgeInsets.only(top: 10),
  //                   child: Column(
  //                     crossAxisAlignment:.start,
  //                     children: [
  //                       TextFormField(
  //                         textAlignVertical:TextAlignVertical(y:0.5),controller: p.controller,
  //                         decoration: InputDecoration(
  //                           hintText: 'Title',
  //                           hintStyle: TextStyle(color: Colors.white),
  //                           border: InputBorder.none,
  //                         ),
  //                       ),
  //                       Divider(color: Colors.white54),
  //                       TextFormField(controller: p.descriptioncontroller,
  //                         decoration: InputDecoration(
  //                           hintText:'Description',
  //                           hintStyle: TextStyle(color: Colors.white),
  //                           border: InputBorder.none,
  //                         ),
  //                       ),
  //                       Divider(color: Colors.white54),
  //                       TextFormField(controller: p.datecontroller,
  //                         decoration:InputDecoration(
  //                           labelText: 'Select Date',
  //                           labelStyle: TextStyle(color: Colors.white),
  //                           border: InputBorder.none,
  //                           suffixIcon: Icon(Icons.calendar_today_rounded,color: Colors.white,),
  //                         ),
  //                         onTap: () async {
  //                           p.pickDate(context);
  //                         },
  //                       ),
  //                       Divider(color: Colors.white54),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height:30),
  //               Expanded(
  //                 child: Container(
  //                   width:550,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(40),
  //                       topRight: Radius.circular(40),
  //                     ),
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.symmetric(vertical:20,horizontal:20),
  //                     child: Column(
  //                       children: [
  //                         Row(
  //                           children: [
  //                             GestureDetector(
  //                               onTap: (){
  //                                 p.pickStartTime(context);
  //                               },
  //                               child: Expanded(
  //                                   child: _timeField(
  //                                     'Start Time',
  //                                     p.startTime==null?
  //                                     "7:00AM":p.startTime!,
  //                                   )
  //                               ),
  //                             ),
  //                             SizedBox(width:40),
  //                             GestureDetector(
  //                               onTap: (){
  //                                 p.pickEndTime(context);
  //                               },
  //                               child: Expanded(
  //                                 child: _timeField(
  //                                   'End Time',p.endTime==null?
  //                                 "7:00 PM":p.endTime!,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height:30),
  //                         Align(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             "Category",
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 18,
  //                             ),
  //                           ),
  //                         ), SizedBox(height: 20),
  //                         Wrap(
  //                           spacing: 10,
  //                           runSpacing: 10,
  //                           children: [
  //                             _categoryChip("Work", false),
  //                             _categoryChip("Meeting", true),
  //                             _categoryChip("Study", false),
  //                             _categoryChip("Personal", false),
  //                             _categoryChip("Personal", false),
  //                             _categoryChip("Personal", false),
  //                             _categoryChip("Personal", false),
  //                             _categoryChip("Personal", false),
  //                           ],
  //                         ),
  //                         Spacer(),
  //                         // SizedBox(height:70),
  //                         CustomElevatedButton(backgroundColor: CustomColors.lightgreen(context),width:30,height:50,borderRadius: 15,
  //                           onPressed:()async{
  //                             if (p.controller.text.trim().isNotEmpty) {
  //                               context.read<TaskProvider>().addTask(
  //                                 p.controller.text.trim(),
  //                                 p.descriptioncontroller.text.trim(),
  //                                 p.datecontroller.text.trim(),
  //                                 p.startTime.toString(),
  //                                 p.endTime.toString(),
  //                                 p.categorycontroller.text.trim(),
  //                               );
  //                             }
  //                             print(p.startTime);
  //                             print(p.endTime);
  //                             Navigator.pop(context);
  //                           }, widget:Text('Create Task'),)
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ]
  //         );
  //       }
  //   );
  // }

  Widget _body2(context) {
    return Consumer<TaskProvider>(
      builder: (context, p, _) {
        return SingleChildScrollView(
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
                        labelText: 'Select Date',
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
                    TextFormField(
                      controller: p.startTimeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Start Time',
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(
                          Icons.watch_later_outlined,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        p.pickStartTime(context);
                      },
                    ),
                    Divider(color: CustomColors.addtaskdivider(context)),
                    TextFormField(
                      controller: p.endTimeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'End Time',
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(
                          Icons.watch_later_outlined,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        p.pickEndTime(context);
                      },
                    ),
                    Divider(color: CustomColors.addtaskdivider(context)),
                  ],
                ),
              ),
              SizedBox(height:10),
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
                          "Category",
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
                                      'Added Task Sucessfully',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        widget: Text('Create Task'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Widget _categoryChip(
  //   String text,
  //   bool selected,
  //   void Function(bool?) onSelected,
  // ) {
  //   return ChoiceChip(
  //     shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(20)),
  //     backgroundColor: selected
  //         ? CustomColors.addtaskprimarygreen(context)
  //         : Color(0xFFEAFBF0),
  //     label: Text(
  //       text,
  //       style: TextStyle(color: selected ? Colors.white : Colors.black),
  //     ),
  //     selected: selected,
  //     onSelected: onSelected,
  //   );
  // }

  // Widget _timeField(String title, String value) {
  //   return Container(
  //     padding: EdgeInsets.all(15),
  //     decoration: BoxDecoration(
  //       color: Color(0xFFEAFBF0),
  //       borderRadius: BorderRadius.circular(15),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(title),
  //         SizedBox(height: 15),
  //         Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
  //       ],
  //     ),
  //   );
  // }
}
