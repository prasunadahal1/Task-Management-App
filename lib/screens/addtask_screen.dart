
import 'package:flutter/material.dart';
import 'package:task_app/providers/task_providers.dart';
import 'package:provider/provider.dart';
import 'package:task_app/resources/custom.dart';

class AddtaskScreen extends StatefulWidget {
  const AddtaskScreen({super.key});

  @override
  State<AddtaskScreen> createState() => _AddtaskScreenState();
}

class _AddtaskScreenState extends State<AddtaskScreen> {
   Color primaryMint = Color(0xFFA8E6C1);
   Color lightMint = Color(0xFFEAFBF0);
   Color darkMint = Color(0xFF7BCF9D);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryMint,
        title: Text('Create New Task'),
        actions: [
          Icon(Icons.task,color: Colors.black),
          SizedBox(width: 16,)
        ],
      ),
      backgroundColor: primaryMint,
      body: _body2(context),

    );
  }

  Widget _body(context){
    return Consumer<TaskProvider>(
        builder:(context,p,_){
          return Column(
              mainAxisAlignment: .start,
              children:[
                Container(
                  decoration: BoxDecoration(
                    color: primaryMint,
                    borderRadius: BorderRadius.only(),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment:.start,
                      children: [
                        TextFormField(
                          textAlignVertical:TextAlignVertical(y:0.5),controller: p.controller,
                          decoration: InputDecoration(
                            hintText: 'Title',
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(color: Colors.white54),
                        TextFormField(controller: p.descriptioncontroller,
                          decoration: InputDecoration(
                            hintText:'Description',
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(color: Colors.white54),
                        TextFormField(controller: p.datecontroller,
                          decoration:InputDecoration(
                            labelText: 'Select Date',
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            suffixIcon: Icon(Icons.calendar_today_rounded,color: Colors.white,),
                          ),
                          onTap: () async {
                            p.pickDate(context);
                          },
                        ),
                        Divider(color: Colors.white54),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:30),
                Expanded(
                  child: Container(
                    width:550,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:20,horizontal:20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  p.pickStartTime(context);
                                },
                                child: Expanded(
                                    child: _timeField(
                                      'Start Time',
                                      p.startTime==null?
                                      "7:00AM":p.startTime!.format(context),
                                    )
                                ),
                              ),
                              SizedBox(width:40),
                              GestureDetector(
                                onTap: (){
                                  p.pickEndTime(context);
                                },
                                child: Expanded(
                                  child: _timeField(
                                    'End Time',p.endTime==null?
                                  "7:00 PM":p.endTime!.format(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Category",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ), SizedBox(height: 20),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              _categoryChip("Work", false),
                              _categoryChip("Meeting", true),
                              _categoryChip("Study", false),
                              _categoryChip("Personal", false),
                              _categoryChip("Personal", false),
                              _categoryChip("Personal", false),
                              _categoryChip("Personal", false),
                              _categoryChip("Personal", false),
                            ],
                          ),
                          Spacer(),
                          // SizedBox(height:70),
                          CustomElevatedButton(backgroundColor: primaryMint,width:30,height:50,borderRadius: 15,
                            onPressed:()async{
                              if (p.controller.text.trim().isNotEmpty) {
                                context.read<TaskProvider>().addTask(
                                  p.controller.text.trim(),
                                  p.descriptioncontroller.text.trim(),
                                  p.datecontroller.text.trim(),
                                  p.startTimeController.text.trim(),
                                  p.endTimeController.text.trim(),
                                  p.categorycontroller.text.trim(),
                                );
                              }
                              Navigator.pop(context);
                            }, widget:Text('Create Task'),)
                        ],
                      ),
                    ),
                  ),
                ),
              ]
          );
        }
    );
  }

  Widget _body2(context){
    return Consumer<TaskProvider>(
      builder: (context, p, _) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 16),
                decoration: BoxDecoration(
                  color: primaryMint,
                  borderRadius: BorderRadius.only(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      textAlignVertical: TextAlignVertical(y: 0.5),
                      controller: p.controller,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                    Divider(color: Colors.white54),
                    TextFormField(
                      controller: p.descriptioncontroller,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                    Divider(color: Colors.white54),
                    TextFormField(
                      controller: p.datecontroller,
                      decoration: InputDecoration(
                        labelText: 'Select Date',
                        labelStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.calendar_today_rounded, color: Colors.white),
                      ),
                      onTap: () async {
                        p.pickDate(context);
                      },
                    ),
                    Divider(color: Colors.white54),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              p.pickStartTime(context);
                            },
                            child: Expanded(
                              child: _timeField(
                                'Start Time',
                                p.startTime == null
                                    ? "7:00AM"
                                    : p.startTime!.format(context),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              p.pickEndTime(context);
                            },
                            child: Expanded(
                              child: _timeField(
                                'End Time',
                                p.endTime == null
                                    ? "7:00 PM"
                                    : p.endTime!.format(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Category",
                          style: TextStyle(
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
                          _categoryChip("Work", false),
                          _categoryChip("Meeting", true),
                          _categoryChip("Study", false),
                          _categoryChip("Personal", false),
                          _categoryChip("Personal", false),
                          _categoryChip("Personal", false),
                          _categoryChip("Personal", false),
                          _categoryChip("Personal", false),
                        ],
                      ),
                      SizedBox(height: 80),
                      CustomElevatedButton(
                        backgroundColor: primaryMint,
                        width: 30,
                        height: 50,
                        borderRadius: 15,
                        onPressed: () async {
                          if (p.controller.text.trim().isNotEmpty) {
                            context.read<TaskProvider>().addTask(
                              p.controller.text.trim(),
                              p.descriptioncontroller.text.trim(),
                              p.datecontroller.text.trim(),
                              p.startTimeController.text.trim(),
                              p.endTimeController.text.trim(),
                              p.categorycontroller.text.trim(),
                            );
                          }
                          Navigator.pop(context);
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
   Widget _categoryChip(String text, bool selected) {
     return Chip(
       shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(20)),
       backgroundColor:
       selected ? Color(0xFFA8E6C1) : Color(0xFFEAFBF0),
       label: Text(
         text,
         style: TextStyle(
           color: selected ? Colors.white : Colors.black,
         ),
       ),
     );
   }

   Widget _timeField(String title, String value) {
     return Container(
       padding: EdgeInsets.all(15),
       decoration: BoxDecoration(
         color: Color(0xFFEAFBF0),
         borderRadius: BorderRadius.circular(15),
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(title),
           SizedBox(height: 5),
           Text(
             value,
             style: TextStyle(
               fontWeight: FontWeight.bold,
             ),
           ),
         ],
       ),
     );
   }
}

