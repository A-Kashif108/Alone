import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/assignment.dart';
import '../services/notification_service.dart';

class AssignPage extends StatefulWidget {
  const AssignPage({Key? key}) : super(key: key);

  @override
  _AssignPageState createState() => _AssignPageState();
}

class _AssignPageState extends State<AssignPage> {

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Assignments").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData){
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return  Assignment(deadline: data['deadline'],
                      assignment: data['assignment'],course: data['course'],
                      day: data['creation_date'],
                      id: document.id,
                    );
                  }).toList(),
                );
              }
              return const Center(child: CircularProgressIndicator(),);
            }),
    );
  }
}
