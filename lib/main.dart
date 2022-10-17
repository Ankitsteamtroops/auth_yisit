import 'package:flutter/material.dart';
import 'package:project_yisit/authScreens/homepage.dart';
import 'package:project_yisit/authScreens/newPassword.dart';
import 'package:project_yisit/authScreens/reOtpVerificationCode.dart';

import 'authScreens/forgotPassword.dart';
import 'authScreens/resetpassword.dart';
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
      routes: {
        SignIn.id: (context) => SignIn(),
        SignUpPage.id: (context) => SignUpPage(),
        SignUpPage2.id: (context) => SignUpPage2(),
        ForgotPassword.id: (context) => ForgotPassword(),
        // ResetPassword.id: (context) => ResetPassword(),
        VerificationCode.id: (context) => VerificationCode(),
        // ReOtpVerificationCode.id: (context) => ReOtpVerificationCode(),
        NewPassword.id: (context) => NewPassword(),
        // HomePage.id: (context) => HomePage(),
      },
    );
  }
}
