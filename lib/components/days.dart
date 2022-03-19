import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Days extends StatefulWidget {
  const Days({Key? key}) : super(key: key);

  @override
  _DaysState createState() => _DaysState();
}

class _DaysState extends State<Days> {

  String name(int index){
    switch(index){
      case 0 : return "Sunday";
      case 1 : return "Monday";
      case 2 : return "Tuesday";
      case 3 : return "Wednesday";
      case 4 : return "Thursday";
      case 5 : return "Friday";
      case 6 : return "Saturday";
      default:
        return "Error";
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: PageView.builder(
        padEnds: true,

        itemCount: 7,
          itemBuilder: (context ,index){
          return Container(

            decoration: BoxDecoration(
              color: CupertinoColors.secondaryLabel,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Center(
              child: Text(name(index),style: const TextStyle(fontSize: 17,color: Colors.grey),),
            ),
          );
          }
      ),
    );
  }
}
