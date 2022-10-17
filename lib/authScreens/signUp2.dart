import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_yisit/authScreens/homepage.dart';
import 'package:project_yisit/authScreens/signInPage.dart';
import '../json/registerJson.dart';
import '../services/client.dart';
import 'verificationCode.dart';

class SignUpPage2 extends StatefulWidget {
  static String id = "SignupPage2";
  TextEditingController? parentName;
  TextEditingController? studentname;
  TextEditingController? phoneNo;
  SignUpPage2({this.parentName, this.studentname, this.phoneNo});

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  @override
  var userDataid;
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conformpasswordcontroller = TextEditingController();
  TextEditingController parentEmailController = TextEditingController();

  controlandRegisterMethod() {
    String parentcontroller = widget.parentName!.text.toString();
    String studentcontroller = widget.studentname!.text.toString();
    String phncontroller = widget.phoneNo!.text.toString();

    register(
      parent_name: parentcontroller,
      student_name: studentcontroller,
      mobile: phncontroller,
      parentemail: parentEmailController.text.toString(),
      password: passwordcontroller.text.toString(),
    );
  }

  final _formkey = GlobalKey<FormState>();
  bool _secureTextpass1 = true;
  bool _secureTextpass2 = true;
  bool _checkBox = false;

  Future<void> register({
    required String? parent_name,
    required String? student_name,
    required String? parentemail,
    required String? mobile,
    required String password,
  }) async {
    try {
      var user = User(
        parentName: parent_name,
        studentName: student_name,
        email: parentemail,
        mobile: mobile,
        password: password,
        role: 'user',
      );
      // print("parent_name=$parent_name");
      // print("student_name= $student_name");
      // print("parentemail = $parentemail");
      // print("mobile=$mobile");
      // print("password=$password");
      if (_checkBox) {
        var response = await AuthClient().postRegister('/register', user);

        setState(() {
          var values = jsonDecode(response);
          userDataid = values["data"]["userId"];
          print(userDataid);
          // final text = "register done";
          // final snackBar = SnackBar(content: Text(text));
          // ScaffoldMessenger.of(context).showSnackBar((snackBar));

          if ((EmailValidator.validate(parentEmailController.text)) &&
              _checkBox == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerificationCode(
                  uuid: userDataid,
                  email: parentEmailController.text.toString(),
                ),
              ),
            );
          }
          // final text = "verify password ";
          // final snackBar = SnackBar(content: Text(text));
          // ScaffoldMessenger.of(context).showSnackBar((snackBar));
          // return "verify email";
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      height: 36.54,
                      width: 71,
                      child: Image(
                          image: AssetImage('assets/yisit-coloured-logo.png')),
                    ),
                  ),
                  SizedBox(
                    height: 35.46,
                  ),
                  Container(
                    height: 26,
                    width: 80,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFFFFFF),
                          fontFamily: "Google Sans"),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 20,
                    width: 194,
                    // color: Colors.blue,
                    child: const Text(
                      "Get started by creating account.",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFFFF),
                          fontFamily: "Google Sans"),
                    ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        controller: parentEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "it cannot be empty";
                          } else if (EmailValidator.validate(
                                  parentEmailController.text.trim()) ==
                              false) {
                            return "Enter a valid email ";
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar((SnackBar(
                            //   content: Text("verify the email"),
                            //   backgroundColor: Colors.blueGrey,
                            // )));
                          } else
                            return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                child: Icon(
                                  Icons.mail,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          hintText: "Parents Email ID",
                          hintStyle: const TextStyle(
                            fontFamily: "Google Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      //  Enter Password
                      TextFormField(
                        controller: passwordcontroller,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "password cannot be empty";
                          else if (value.length < 8)
                            return "password must be atleast 8";
                          else
                            return null;
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: _secureTextpass1,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 2),
                                child: Icon(
                                  Icons.lock,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _secureTextpass1 = !_secureTextpass1;
                                });
                              },
                              icon: _secureTextpass1
                                  ? Icon(
                                      CupertinoIcons.eye_slash_fill,
                                      color: Color(0xffFFFFFF),
                                    )
                                  : Icon(
                                      CupertinoIcons.eye_fill,
                                      color: Color(0xffFFFFFF),
                                    )),
                          hintText: "Enter Password",
                          hintStyle: TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // Conform password
                      TextFormField(
                        controller: conformpasswordcontroller,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "password cannot be empty";
                          else if (value.length < 8)
                            return "password must be atleast 8";
                          else if (value != passwordcontroller.text.trim())
                            return "recheck the password ";
                          else
                            return null;
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: _secureTextpass2,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 2),
                                child: Icon(
                                  Icons.lock,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _secureTextpass2 = !_secureTextpass2;
                                });
                              },
                              icon: _secureTextpass2
                                  ? const Icon(
                                      CupertinoIcons.eye_slash_fill,
                                      color: Color(0xffFFFFFF),
                                    )
                                  : const Icon(
                                      CupertinoIcons.eye_fill,
                                      color: Color(0xffFFFFFF),
                                    )),
                          hintText: "Confirm Password",
                          hintStyle: const TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Container(
                      height: 40,
                      width: 326,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _checkBox = !_checkBox;
                              });
                            },
                            child: Container(
                              // color: _checkBox ? Colors.green : Colors.black,
                              color: Colors.black,
                              height: 24,
                              width: 24,
                              child: _checkBox
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.square_outlined,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            // color: Colors.red,
                            height: 40,
                            width: 290,
                            child: Center(
                              child: Text.rich(TextSpan(
                                text:
                                    "By clicking continue, you agress to our ",
                                style: const TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 12,
                                  fontFamily: 'Google Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Terms and Conditions",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // navigate to certain page
                                      },
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " and the",
                                  ),
                                  TextSpan(
                                    text: " Privacy Policy.",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // navigate to certain page
                                      },
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // signUp
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_formkey.currentState!.validate()) {
                          controlandRegisterMethod();
                        }
                      });
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
                                'SIGN UP',
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
                  SizedBox(
                    height: 25,
                  ),
                  //Already have an account ?
                  Center(
                    child: Container(
                      height: 20,
                      width: 242,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account ?",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 15,
                              fontFamily: 'Google Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              SignIn.id,
                            ),
                            child: Container(
                              height: 20,
                              width: 50,
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xffFFFFFF),
                                  fontSize: 16,
                                  fontFamily: 'Google Sans',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: Container(
                      height: 24,
                      width: 89,
                      child: const Center(
                        child: Text(
                          "Made with science by",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image(
                          image:
                              AssetImage('assets/STILr-App-asset-white.png')),
                    ),
                  ),
                  // SizedBox(
                  //   height: 57,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
