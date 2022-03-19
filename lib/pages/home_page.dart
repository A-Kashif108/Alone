
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mdg_project/components/floating_button.dart';
import 'package:mdg_project/pages/assignment_page.dart';
import 'package:mdg_project/pages/query_page.dart';

import '../services/notification_service.dart';
import 'classes_page.dart';

class HomePage extends StatefulWidget {
  final String enroll;

  const HomePage({Key? key,required this.enroll}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget? _child;


  @override
  void initState() {
    DateFormat('EEEE')
        .format(DateTime.now()).toLowerCase()!="saturday"?FirebaseFirestore
        .instance.collection("Classes").doc(DateFormat('EEEE')
        .format(DateTime.now()).toLowerCase()).collection("class").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((data) {
        LocalNotificationService.showScheduledNotification(
            title: data['course'],
            body: 'Class Start',
            scheduledDate: DateTime.parse((DateFormat('yyyy-MM-dd').format(DateTime.now())+" ")+data['start time']));
      });
    })
        :null;

    FirebaseFirestore.instance.collection('Assignments').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((data) {
        LocalNotificationService.showScheduledNotification(
          title: data['course'],
          body: "Only 1 hour left for Assignment",
          scheduledDate: DateTime.parse(data['deadline']).add(const Duration(hours: -1)),
          // scheduledDate: DateTime.now().add(const Duration(seconds: 5)),
        );
      });

    });
    _child = const AssignPage();
    super.initState();
    LocalNotificationService.init(initScheduled: true);
    listenNotifications;
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }
  void listenNotifications() =>
      LocalNotificationService.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  const HomePage(enroll: '21114020',),
      ));


  @override
  Widget build(BuildContext context) {



    double h =MediaQuery.of(context).size.height;
    double w =MediaQuery.of(context).size.width;
    return Container(
      height: h,
      width: w,
      decoration: const BoxDecoration(
        color: CupertinoColors.darkBackgroundGray,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: CupertinoColors.systemFill,
          elevation: 0.5,
          title:   const Text(
            "Alone",
            style: TextStyle(color: CupertinoColors.lightBackgroundGray,fontSize: 22),

          ),
        ),
        body:  _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                icon: Icons.school,
                backgroundColor: const Color(0xFFEC4134),
                extras: {"label": "Assignment"}
            ),
            FluidNavBarIcon(
                icon: Icons.access_time_rounded,
                backgroundColor:  Colors.green,
                extras: {"label": "Classes"}),
            FluidNavBarIcon(
                icon: Icons.question_answer,
                backgroundColor:  Colors.blueAccent,
                extras: {"label": "Query"}),
          ],
          animationFactor: 0.7,
          onChange: _handleNavigationChange,
          style: const FluidNavBarStyle(
            iconUnselectedForegroundColor: CupertinoColors.lightBackgroundGray,
            iconSelectedForegroundColor: CupertinoColors.white,
            barBackgroundColor: CupertinoColors.secondaryLabel,
          ),
          scaleFactor: 1.5,
          defaultIndex: 0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
        floatingActionButton:  const FloatButton(),
      ),
    );
  }

  Future<void> _handleNavigationChange(int index)  async {
    setState(()  {
      switch (index) {
        case 0:
          _child =  const AssignPage();
          break;
        case 1:
          _child = const ClassesPage();
          break;
        case 2:
          _child = const QueryPage();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 5),
        child: _child,
      );
    });

  }

}
