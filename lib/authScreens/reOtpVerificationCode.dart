// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart';
// import 'package:project_yisit/authScreens/newPassword.dart';
// import 'package:project_yisit/json/jsonClasses.dart';

// import '../services/client.dart';

// class ReOtpVerificationCode extends StatefulWidget {
//   static String id = 'ReOtpverification_code';
//   var uuid;
//   var email;
//   ReOtpVerificationCode({this.uuid, this.email}) {
//     // print(uuid);
//   } //constructor

//   @override
//   State<ReOtpVerificationCode> createState() => _ReOtpVerificationCodeState();
// }

// class _ReOtpVerificationCodeState extends State<ReOtpVerificationCode> {
//   TextEditingController otp1 = TextEditingController();
//   TextEditingController otp2 = TextEditingController();
//   TextEditingController otp3 = TextEditingController();
//   TextEditingController otp4 = TextEditingController();
//   var recievedOtp = '';
//   var emailOtp;

//   Future<void> verify({
//     required String? userid,
//     required String? otp,
//   }) async {
//     try {
//       var user = VerifyUser(userId: userid, otp: otp);
//       print(" user id : '${userid}'");
//       var response = await AuthClient().postVerifyUser('/verify-user', user);
//       print(response);
//       var values = jsonDecode(response);

//       //check this

//       emailOtp = values["data"]["otp"]; //check this
//       if (otp == emailOtp) {
//         Navigator.pushNamed(context, NewPassword.id);
//       } else {
//         final text = "Enter a valid Otp";
//         final snackBar = SnackBar(content: Text(text));
//         ScaffoldMessenger.of(context).showSnackBar((snackBar));
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<void> resendOtp({
//     required String? userid,
//     required String? parentemail,
//   }) async {
//     try {
//       var _user = OtpResend(
//         userId: userid,
//         email: parentemail,
//       );
//       var response = await AuthClient().postResendCode("/resend-otp", _user);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 212,
//             ),
//             Center(
//               child: Container(
//                 height: 36,
//                 width: 212,
//                 child: const Center(
//                   child: Text(
//                     "Verification Code",
//                     style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xffFFFFFF),
//                         fontFamily: "Poppins"),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 19,
//             ),
//             Center(
//               child: Container(
//                 height: 46,
//                 width: 293,
//                 child: const Center(
//                   child: Text(
//                     "A new code has been sent to your associated mail id",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xffFFFFFF),
//                         fontFamily: "Poppins"),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 57,
//             ),
//             Container(
//               height: 69,
//               width: 294,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 // color: Color(0xff21C4A7),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   OtpBox(
//                     otpController: otp1,
//                   ),
//                   OtpBox(
//                     otpController: otp2,
//                   ),
//                   OtpBox(
//                     otpController: otp3,
//                   ),
//                   OtpBox(
//                     otpController: otp4,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 52,
//             ),
//             Container(
//               height: 20,
//               width: 151,
//               // color: Color(0xff21C4A7),
//               child: const Center(
//                 child: Text(
//                   "Didn’t Receive an OTP ?",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Color(0xffFFFFFF),
//                     fontSize: 13,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 resendOtp(
//                   userid: widget.uuid,
//                   parentemail: widget.email,
//                 );

//                 final text = "otp send";
//                 final snackBar = SnackBar(content: Text(text));
//                 ScaffoldMessenger.of(context).showSnackBar((snackBar));
//               },
//               child: Container(
//                 height: 18,
//                 width: 71,
//                 // color: Color(0xff21C4A7),
//                 child: const Center(
//                   child: Text(
//                     "Resend OTP",
//                     style: TextStyle(
//                       decoration: TextDecoration.underline,
//                       color: Color(0xffFFFFFF),
//                       fontSize: 12,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 45,
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   recievedOtp = otp1.text.toString() +
//                       otp2.text.toString() +
//                       otp3.text.toString() +
//                       otp4.text.toString();
//                 });
//                 verify(
//                   userid: widget.uuid,
//                   otp: recievedOtp,
//                 );
//                 // also here we can put that scaffold
//               },
//               child: Container(
//                 height: 56,
//                 width: 311,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(96),
//                   color: Color(0xff21C4A7),
//                 ),
//                 child: Center(
//                   child: Container(
//                     height: 30,
//                     width: 311,
//                     child: const Center(
//                       child: Text(
//                         'Submit',
//                         style: TextStyle(
//                           color: Color(0xffFFFFFF),
//                           fontSize: 20,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

// class OtpBox extends StatelessWidget {
//   TextEditingController otpController;
//   OtpBox({required this.otpController});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 69,
//       width: 60,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: Color.fromARGB(255, 18, 18, 18),
//       ),
//       child: TextFormField(
//         controller: otpController,
//         onChanged: (value) {
//           if (value.length == 1) {
//             FocusScope.of(context).nextFocus();
//           }
//         },
//         style: TextStyle(color: Colors.white),
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly
//         ],
//       ),
//     );
//   }
// }