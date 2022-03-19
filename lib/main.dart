import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mdg_project/pages/enrollment.dart';
import 'package:mdg_project/pages/home_page.dart';
import 'package:mdg_project/pages/phone_auth.dart';
import 'package:mdg_project/services/auth_services.dart';
import 'package:mdg_project/services/localdb.dart';
import 'package:mdg_project/services/notification_service.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(message.data.toString());
  }
  if (kDebugMode) {
    print(message.notification!.title);
  }
}



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogIn = false;

  getLoggedInState() async{
    await LocalDataSaver.getLogData().then((value){
      setState((){
        isLogIn = value!;
      });
    });
  }


  Auth authClass = Auth();
  Widget currentPage = const PhoneAuthPage();

  @override
  void initState() {
    super.initState();
    getLoggedInState();
    LocalNotificationService.init(initScheduled: true);
    listenNotifications;
    checkLogin();
  }
  void listenNotifications() =>
      LocalNotificationService.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  const HomePage(enroll: '21114020',),
      ));

  checkLogin() async {
    String? token = await authClass.getToken();
    if (kDebugMode) {
      print("token");
    }
    if (token!=null) {
      setState(() {
        currentPage = const Enrollment();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.teal,),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),

      home: isLogIn?const HomePage(enroll: '21114020'):const PhoneAuthPage(),

    );
  }
}
