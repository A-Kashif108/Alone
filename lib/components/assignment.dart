
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:intl/intl.dart';
import 'package:mdg_project/services/notification_service.dart';

class Assignment extends StatefulWidget {
  final String course;
  final String deadline;
  final String assignment;
  final String day;
  final String id;

   const Assignment({Key? key, required this.day, required this.course,required this.deadline,required this.assignment,required this.id}) : super(key: key);

  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {




  @override
  Widget build(BuildContext context) {
    int totalhour = DateTime.parse(widget.deadline).difference(DateTime.parse(widget.day)).inHours;
    int totalminute = DateTime.parse(widget.deadline).difference(DateTime.parse(widget.day)).inMinutes;
    int hourLeft =  DateTime.parse(widget.deadline).difference(DateTime.now()).inHours;
    int minuteLeft =  DateTime.parse(widget.deadline).difference(DateTime.now()).inMinutes;
    bool isDisabled=false;
    Widget button(){
      return  ElevatedButton(

          onPressed: isDisabled?null:(){

            LocalNotificationService.showScheduledNotification(
                title: widget.course,
                body: 'only 1 hour left for $widget.assignment',
                scheduledDate: DateTime.parse(widget.deadline).add(const Duration(hours: -1)));
              isDisabled =true;

          }, child:  Text(
        !isDisabled?
          'notify':'notified'
      ));
    }
    if(minuteLeft<=0){
      CollectionReference users = FirebaseFirestore.instance.collection('Assignments');
      users.doc(widget.id.toString())
            .delete()
            .then((value) => print("Assignment Deleted"))
            .catchError((error) => print("Failed to delete Assignment: $error"));
    }



    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.fromLTRB(0, h*0.02, 0, h*0.02),
      child: Container(
        height: 130 ,
        width: w*0.88 ,
        decoration:   BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.blueGrey.shade900,
                Colors.blueGrey,
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),

          borderRadius: BorderRadius.circular(15.0),


        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(hourLeft>=0?
                  "$hourLeft hour left":"Time up",
                  style: const TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: h*0.01,
                ),
                CircularCountdown(
                  countdownTotal: totalhour!=0?(totalhour>20?20:totalhour):totalminute,
                  diameter: h*0.07,
                  countdownRemaining: hourLeft>=0?totalhour>20?((hourLeft*20)~/totalhour):hourLeft:minuteLeft,
                  countdownRemainingColor: Colors.orangeAccent,
                  countdownCurrentColor: Colors.tealAccent,
                  countdownTotalColor: Colors.teal,
                  strokeWidth: 7,
                ),

              ],
            ),
             SizedBox(
              width: w*0.05,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.course,
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.sticky_note_2,color: CupertinoColors.systemTeal,size: 17,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.assignment,
                        style: const TextStyle(
                          color: CupertinoColors.systemGreen,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children:  [
                    const Icon(CupertinoIcons.clock_fill,color: CupertinoColors.systemTeal,size: 17,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(widget.deadline)),
                        style: const TextStyle(
                          color: CupertinoColors.activeGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
            button(),
          ],
        ),
      ),
    );

  }

}
