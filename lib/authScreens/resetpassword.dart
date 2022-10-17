// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ResetPassword extends StatelessWidget {
//   static String id = "ResetPassword";

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 135,
//                 ),
//                 Container(
//                   height: 28,
//                   width: 167,
//                   // color: Colors.blue,
//                   child: const Center(
//                     child: Text(
//                       "Reset Password",
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xffFFFFFF),
//                           fontFamily: "Google Sans"),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 59,
//                 ),
//                 //new pass
//                 NameBox(
//                   icon: Icons.lock,
//                   name: "New Password",
//                   eyeslash: CupertinoIcons.eye_slash_fill,
//                 ),

//                 SizedBox(
//                   height: 30,
//                 ),
//                 NameBox(
//                   icon: Icons.lock,
//                   name: "Confirm Password",
//                   eyeslash: CupertinoIcons.eye_slash_fill,
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   height: 50,
//                   width: 350,
//                   // color: Colors.yellow,
//                   child: GestureDetector(
//                     onTap: () {
//                       // Navigator.pushNamed(context, SignUpPage2.id);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: Color(0xff21C4A7),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 99, vertical: 15),
//                         child: Container(
//                           height: 18,
//                           width: 151,
//                           child: const Text(
//                             'RESET PASSWORD',
//                             style: TextStyle(
//                               color: Color(0xffFFFFFF),
//                               fontSize: 15,
//                               fontFamily: 'Disengaged',
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Container NameBox({icon, name, eyeslash}) {
//   return Container(
//     height: 32,
//     width: 350,
//     // color: Colors.green,
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 20,
//           width: 20,
//           child: Padding(
//             padding: const EdgeInsets.only(
//               left: 3,
//               right: 3,
//               top: 2,
//               bottom: 2,
//             ),
//             child: Icon(
//               icon,
//               // size: 19,
//               color: Color(0xffFFFFFF),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 8,
//         ),
//         Expanded(
//           child: Container(
//             height: 27,
//             width: 250,
//             // color: Colors.red,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 7, left: 20),
//               child: TextFormField(
//                 style: TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: name,
//                   hintStyle: const TextStyle(
//                     fontFamily: "Google Sans",
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16,
//                     color: Color(0xffFFFFFF),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Container(
//           width: 20,
//           height: 20,
//           color: Colors.black,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//             child: Icon(
//               eyeslash,
//               size: 18,
//               color: Color(0xffFFFFFF),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
