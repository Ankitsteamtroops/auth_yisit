import 'package:flutter/material.dart';
import 'package:project_yisit/authScreens/homepage.dart';
import 'package:project_yisit/authScreens/newPassword.dart';
import 'authScreens/forgotPassword.dart';
import 'authScreens/signInPage.dart';
import 'authScreens/signUp.dart';
import 'authScreens/signUp2.dart';
import 'authScreens/verificationCode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xff062537),
      ),
      home: SignIn(),
    );
  }
}
