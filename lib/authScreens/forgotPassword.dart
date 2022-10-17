import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:project_yisit/json/jsonClasses.dart';
import '../services/client.dart';
import 'verificationCode.dart';

class ForgotPassword extends StatefulWidget {
  static String id = "forgotPassword";

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var data;
  void resendOtp({String? email}) async {
    // just put here the email and userid

    try {
      var _otpResend = OtpResend(
        email: email,
        userId: "",
      );

      //here xheck the endpoint

      var response =
          await AuthClient().postResendCode('/resend-otp', _otpResend);
      print(response);
      setState(() {
        data = response;
      });

      if (_formkey.currentState!.validate()) {
        await Future.delayed(Duration(seconds: 1));
        if (EmailValidator.validate(emailController.text.trim())) {
          if (response.email == emailController.text.trim()) {
            Navigator.pushNamed(context, VerificationCode.id);
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 135,
                  ),
                  Container(
                    height: 28,
                    width: 189,
                    child: const Text(
                      "Forgot Password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFFFFFF),
                          fontFamily: "Google Sans"),
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Container(
                    height: 30,
                    width: 342,
                    child: const Center(
                      child: Text(
                        "Don’t worry it happens, Please enter the mail id associated with your account.",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffFFFFFF),
                            fontFamily: "Google Sans"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(color: Colors.white),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "email cannot be empty";
                      } else if (EmailValidator.validate(
                              emailController.text.trim()) ==
                          false) {
                        return "verify email again ";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        height: 20,
                        width: 20,
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.mail,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      hintText: "Email ID",
                      hintStyle: TextStyle(
                        fontFamily: "Google Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    onTap: () {
                      resendOtp(
                        email: emailController.text.toString(),
                      );
                    },
                    child: Center(
                      child: Container(
                        height: 56,
                        width: 311,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(96),
                          color: Color(0xff21C4A7),
                        ),
                        child: Center(
                          child: Container(
                            // color: Colors.red,
                            height: 30,
                            width: 311,
                            child: const Center(
                              child: Text(
                                'Send OTP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
