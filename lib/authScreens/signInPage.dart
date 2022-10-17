import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_yisit/authScreens/homepage.dart';
import 'package:project_yisit/authScreens/signUp.dart';
import 'package:project_yisit/services/client.dart';
import '../json/jsonClasses.dart';
import 'forgotPassword.dart';

class SignIn extends StatefulWidget {
  static String id = "signInPage";
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _secureText = true;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var data;
  var userEmail, userPassword;
  void login({String? email, String? password}) async {
    try {
      if (_formkey.currentState!.validate()) {
        var _userSignin = LoginUser(
          userEmail: email,
          password: password,
        );
        var response = await AuthClient().postLogin('/login', _userSignin);
        print(response);
        setState(() {
          data = response;
          var value = jsonDecode(response);
          userEmail = value["data"]["user"]["email"];
          userPassword = value["data"]["user"]["password"];
          print("userEmail::: $userEmail");
          print("userpassword::: $userPassword");
        });
//&&           userPassword == passwordController.text.trim()

        await Future.delayed(Duration(seconds: 1));
        if (EmailValidator.validate(usernameController.text.trim())) {
          if (userEmail == usernameController.text.trim()) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
                (route) => false);
          }
        } else {
          final text = "verify email and username again ";
          final snackBar = SnackBar(content: Text(text));
          ScaffoldMessenger.of(context).showSnackBar((snackBar));
          // return "verify email";
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 55,
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
                    width: 161,
                    // color: Colors.blue,
                    child: const Text(
                      "Welcome, Back",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFFFFFF),
                          fontFamily: "Google Sans"),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "email cannot be empty";
                          } else if (EmailValidator.validate(
                                  usernameController.text.trim()) ==
                              false) {
                            return "verify email and password again ";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
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
                                  Icons.mail,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          hintText: "Username/Email/Phone number",
                          hintStyle: const TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 29,
                      ),
                      // password
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "password cannot be empty";
                          else if (value.length < 6)
                            return "password must be atleast 6";
                          // else if (value != (passwordController.text)) {
                          //   final text = "verify password ";
                          //   final snackBar = SnackBar(content: Text(text));
                          //   ScaffoldMessenger.of(context).showSnackBar((snackBar));
                          //   return "verify email";
                          // }
                          else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: _secureText,
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
                                  _secureText = !_secureText;
                                });
                              },
                              icon: _secureText
                                  ? const Icon(
                                      CupertinoIcons.eye_slash_fill,
                                      color: Color(0xffFFFFFF),
                                    )
                                  : const Icon(
                                      CupertinoIcons.eye_fill,
                                      color: Color(0xffFFFFFF),
                                    )),
                          hintText: "Password",
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
                    height: 11,
                  ),
                  // forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        ForgotPassword.id,
                      ),
                      child: Container(
                        height: 18,
                        width: 113,
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFFFFFF),
                              fontFamily: "Google Sans"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () {
                      login(
                        email: usernameController.text.toString(),
                        password: passwordController.text.toString(),
                      );
                    },
                    child: Center(
                      child: Container(
                        height: 56,
                        width: 311,
                        // color: Colors.red,
                        child: Container(
                          height: 30,
                          width: 311,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(96),
                            color: Color(0xff21C4A7),
                          ),
                          child: const Center(
                            child: Text(
                              'SIGN IN',
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
                  const SizedBox(
                    height: 35,
                  ),
                  // divider or
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.36),
                        child: Container(
                          height: 18,
                          width: 15.91,
                          child: const Text(
                            "Or",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Center(
                    child: Container(
                      height: 20,
                      width: 228,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20,
                            width: 172,
                            // color: Colors.green,
                            child: const Text(
                              "Don’t have an account ?",
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 15,
                                fontFamily: 'Google Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              SignUpPage.id,
                            ),
                            child: Container(
                              height: 20,
                              width: 56,
                              child: const Text(
                                "Sign up",
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
                  const SizedBox(
                    height: 120,
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
