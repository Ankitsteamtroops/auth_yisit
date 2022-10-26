import 'package:flutter/material.dart';
import 'package:project_yisit/json/jsonClasses.dart';
import 'package:project_yisit/services/client.dart';

import 'homepage.dart';

class NewPassword extends StatefulWidget {

  var email;
  var OtpCode;
  NewPassword({this.email, this.OtpCode});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController newpasswordcontroller = TextEditingController();
  TextEditingController conformnewpasswordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> conformNewPassword() async {
    try {
      var pass = ResetPassword(
        email: widget.email,
        code: widget.OtpCode,
        password: newpasswordcontroller.text.trim(),
      );
      var response =
          await AuthClient().postResetPassword('/reset-password', pass);
      print(response); // check response
      if (_formkey.currentState!.validate()) {
        //put validation on matching something it will navigate to next screen......
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
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
                    height: 134,
                  ),
                  Container(
                    height: 33,
                    width: 276,
                    child: const Text(
                      "Enter your new password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFFFF),
                          fontFamily: "Poppins"),
                    ),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: newpasswordcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty)
                        return "password cannot be empty";
                      else if (value.length < 8)
                        return "password must be atleast 8";
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        height: 20,
                        width: 20,
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.lock,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      hintText: "Your new Password",
                      hintStyle: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: conformnewpasswordcontroller,
                    validator: (value) {
                      if (value!.isEmpty)
                        return "field cannot be empty";
                      else if (value.length != 8)
                        return "password must be 8";
                      else if (value != newpasswordcontroller.text.trim())
                        return "recheck the password ";
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        height: 20,
                        width: 20,
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.lock,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      hintText: "Confirm Password",
                      hintStyle: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 73,
                  ),
                  GestureDetector(
                    onTap: () {
                      conformNewPassword();
                      // Navigator.pushNamed(context, VerificationCode.id);
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
                            height: 30,
                            width: 311,
                            child: const Center(
                              child: Text(
                                'Confirm',
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
