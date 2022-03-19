import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mdg_project/services/notification_service.dart';

class ClassesWidget extends StatefulWidget {
  final String start;
  final String className;
  final String teacher;
  final String end;
  final String index;

  const ClassesWidget({Key? key,required this.start, required this.className,
    required this.teacher ,required this.end, required this.index}) : super(key: key);

  @override
  _ClassesWidgetState createState() => _ClassesWidgetState();
}

class _ClassesWidgetState extends State<ClassesWidget> {




  bool check(){
    if(
    (DateTime.parse(widget.end).difference(DateTime.now()).inMinutes>=0)&&
        (DateTime.now().difference(DateTime.parse(widget.start)).inMinutes>=0)
    ){
     return true;
    }
    return false;
  }

  Widget widget1(bool Function() check){
    return Column(
      children: [
        Container(
          height: 20,
          width: 20,
          child: Center(
            child: check()?Container(
              height: 13,
              width: 13,
              decoration: const BoxDecoration(
                color: Colors.yellowAccent,
                shape: BoxShape.circle,
              ),
            ):const SizedBox(),
          ),
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 6,
          height: 70,
          decoration:  const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                offset: Offset(0, -1),
              ),
            ],
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
  Widget widget3(bool Function() check){
    return Column(
      children: [
        Container(
          width: 6,
          height: 70,
          decoration:  const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                offset: Offset(0, 1),
              ),
            ],
            color: Colors.blue,
          ),
        ),
        Container(
          height: 20,
          width: 20,
          child: Center(
            child: check()?Container(
              height: 13,
              width: 13,
              decoration: const BoxDecoration(
                color: Colors.yellowAccent,
                shape: BoxShape.circle,
              ),
            ):const SizedBox(),
          ),
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
  Widget widget2(bool Function() check){
    return Column(
      children: [
        Container(
          width: 6,
          height: 50,
          decoration:  const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                offset: Offset(0, 1),
              ),
            ],
            color: Colors.blue,
          ),
        ),
        Container(
          height: 20,
          width: 20,
          child: Center(
            child: check()?Container(
              height: 13,
              width: 13,
              decoration: const BoxDecoration(
                color: Colors.yellowAccent,
                shape: BoxShape.circle,
              ),
            ):const SizedBox(),
          ),
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 6,
          height: 50,
          decoration:  const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                offset: Offset(0, -1),
              ),
            ],
            color: Colors.blue,
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {

    return Row(
          children: [
            (int.parse(widget.index)!=4)?(int.parse(widget.index)==1)?widget1(check):widget2(check):widget3(check),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Row(
                children: [
                  SizedBox(
                    height: 70,
                    child: Column(
                      children:  [
                          Text(
                              widget.className,
                              style:  TextStyle(
                                color: check()?CupertinoColors.extraLightBackgroundGray:CupertinoColors.inactiveGray,
                                fontSize: 17,
                              ),
                            maxLines: 1,
                          ),

                        const SizedBox(
                          height: 5,
                        ),

                          Text(
                              DateFormat('hh:mm a').format(DateTime.parse(widget.start))+" to "
                                  +DateFormat('hh:mm a').format(DateTime.parse(widget.end)),
                            style:  TextStyle(
                              color: check()?CupertinoColors.activeBlue:CupertinoColors.inactiveGray,
                            ),

                        ),

                      const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.teacher,
                          style:  TextStyle(
                            color: check()?CupertinoColors.activeGreen:CupertinoColors.inactiveGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
