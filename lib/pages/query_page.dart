import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/notification_service.dart';

class QueryPage extends StatelessWidget {
  const QueryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:   [
          ElevatedButton(
              onPressed: (){
                LocalNotificationService.showScheduledNotification(
                    title: "check",
                    body: "body",
                  scheduledDate: DateTime.now().add(const Duration(seconds: 10)),
                );
              },
              child: const Text("notify"),
          ),

          const Text("This feature is under process",
            style: TextStyle(
              color: Colors.white70,
            ),

          ),
        ],
      ),
    );
  }
}
