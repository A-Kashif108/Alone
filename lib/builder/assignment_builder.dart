import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mdg_project/services/notification_service.dart';
String course="";
String date="";
String day="";
DateTime deadLine=DateTime.now();
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
String assignment="";

class Assignment_Builder extends StatefulWidget {
  const Assignment_Builder({Key? key}) : super(key: key);

  @override
  _Assignment_BuilderState createState() => _Assignment_BuilderState();
}

class _Assignment_BuilderState extends State<Assignment_Builder> {

  final TextEditingController _course = TextEditingController();

  final TextEditingController _assignment = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: CupertinoColors.white,
          height: h,
          width: w,
          child: Padding(
            padding: const EdgeInsets.all(37.0),
            child: Column(
              children:  [
                const Text(
                  "Create Assignment",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
                SizedBox(
                  height: h*0.1,
                ),
                Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _course,
                            onChanged: (value){
                              setState(() {
                                course = value;
                              });
                            },
                            decoration: InputDecoration(
                              label: const Text("Course"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DateTimeFormField(
                            dateFormat: dateFormat,
                            decoration:  InputDecoration(

                              hintStyle: const TextStyle(color: Colors.black45),
                              errorStyle: const TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
                              suffixIcon: const Icon(Icons.event_note),
                              labelText: 'Deadline',
                            ),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                            onDateSelected: (DateTime value) {
                              day = dateFormat.format(deadLine);
                              deadLine = value;
                              date = dateFormat.format(deadLine);
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _assignment,
                            onChanged: (value){
                              setState(() {
                                assignment = value;
                              });

                            },
                            decoration: InputDecoration(
                              label: const Text("Assignment"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
                SizedBox(
                  height: h*0.1,
                ),
                ElevatedButton(
                    onPressed: ()async{

                      await FirebaseFirestore.instance.collection('Assignments').add({
                        'course' :course,
                        'deadline' :date,
                        'assignment' :assignment,
                        'creation_date' :day,
                      }).whenComplete(() {
                        _assignment.clear();
                        _course.clear();
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Create"),
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}

