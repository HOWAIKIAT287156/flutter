import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookbytes/models/user.dart';
import 'package:bookbytes/shared/ServerConfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MainPage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
  super.initState();
  checkandlogin(); 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(200, 242, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              'BookBytes',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              'Good Things Take Time',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
  checkandlogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('email') ?? '';
  String password = prefs.getString('password') ?? '';
  bool rem = prefs.getBool('rem') ?? false;

  if (rem) {
    try {
      final response = await http.post(
        Uri.parse("${ServerConfig.server}/bookbytes/php/userlogin.php"),
        body: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['status'] == "success") {
          User user = User.fromJson(data['data']);
          Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (content) => MainPage(
                  userdata: user,
                ),
              ),
            ),
          );
        } else {
           User user = User(
                userid: "0",
                useremail: "unregistered@email.com",
                username: "Unregistered",
                userdate: "",
                userpassword: "");
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainPage(
                              userdata: user,
                            ))));
        }
      }
    } catch (error) {
      // Handle errors that occurred during the HTTP request
      // You may want to display an error message or take appropriate action
    }
  }
}
}








