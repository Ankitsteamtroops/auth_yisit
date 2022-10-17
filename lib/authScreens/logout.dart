import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  Future<void> logouthere() async {
    final response = await http
        .get(Uri.parse('https://yisit-backend.herokuapp.com/logout-user'));
    if (response.statusCode == 200) {
      // var res = jsonDecode(response.body.toString());
      // print(res);
      print('Account logout successfully');
    } else {
      print("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text(
                'done',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFFFFFF),
                    fontFamily: "Google Sans"),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //logout
          GestureDetector(
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
                      'logout',
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
        ],
      ),
    );
  }
}
