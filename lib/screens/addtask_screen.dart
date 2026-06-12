
import 'package:flutter/material.dart';

class AddtaskScreen extends StatefulWidget {
  const AddtaskScreen({super.key});

  @override
  State<AddtaskScreen> createState() => _AddtaskScreenState();
}

class _AddtaskScreenState extends State<AddtaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
        mainAxisAlignment: .center,
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.lightBlue,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Title'
              ),
              textAlign: TextAlign.center,
              autofocus: true,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText:'Description'
              ),
              textAlign: TextAlign.center,
              autofocus: true,
            ),
            TextFormField(
              decoration:InputDecoration(
                labelText: 'Select Date',
                suffixIcon: Icon(Icons.calendar_today_rounded,),
                //hintText:'Time'
              ),
              onTap: () async {
                DateTime? pickdate=  await showDatePicker(context: context,initialDate:DateTime.now(),
                    firstDate:DateTime(2000), lastDate:DateTime(2101));
              },
              textAlign: TextAlign.center,
              autofocus: true,
            ),
            ElevatedButton(onPressed: (){}, child:Text('Add'))
          ],
        ),
      ),
    );
  }
}

