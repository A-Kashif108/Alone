import 'package:flutter/material.dart';
import 'package:mdg_project/pages/home_page.dart';
import 'package:mdg_project/pages/login_page.dart';
import 'package:mdg_project/pages/otp_page.dart';
import 'package:mdg_project/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.teal,),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: "/login",
      routes: {
        "/": (context)=> const LoginPage(),
        MyRoutes.homePage : (context)=> const HomePage(),
        MyRoutes.loginPage : (context)=> const LoginPage(),
        MyRoutes.otpPage : (context) => const OtpPage(),
      },
    );
  }
}
