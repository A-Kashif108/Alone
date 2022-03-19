import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mdg_project/builder/classes_builder.dart';

import '../services/notification_service.dart';

class ClassesPage extends StatelessWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat date = DateFormat('yyyy-MM-dd');
    return Column(
      children: [
        Container(
          color: Colors.blue.shade900,
          height: 100,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child:  SizedBox(
              height: 100,
                width: 50,
                child: Center(child: Text(
                    DateFormat('EEEE').format(DateTime.now()),
                  style:  TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
            ),
        ),
        // Container(
        //   height: 100,
        //   color: Colors.black87,
        //   child: const Days(),
        // ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height*0.71,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(20, 70, 0, 0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: DateFormat('EEEE')
                        .format(DateTime.now()).toLowerCase()!="saturday"?FirebaseFirestore
                        .instance.collection("Classes").doc(DateFormat('EEEE')
                        .format(DateTime.now()).toLowerCase()).collection("class").snapshots()
                        :FirebaseFirestore
                        .instance.collection("Classes").doc("monday").collection("class").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasData){
                        return ListView(
                          scrollDirection: Axis.vertical,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                            return  ClassesWidget(
                                start: date.format(DateTime.now())+" "+data['start time'],
                                className: data['course'], teacher: data['teacher'],
                                end: date.format(DateTime.now())+" "+data['end time'],
                                index: data['index']);
                          }).toList(),
                        );
                      }
                      return const Center(child: CircularProgressIndicator(),);
                    })

          ),
        ),
      ],
    );
  }
}
