import 'dart:convert';
import 'package:bookbytes/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookbytes/Pages/MainPage.dart';
import 'package:bookbytes/UserHandling.dart/ForgotPass.dart';
import 'package:bookbytes/shared/ServerConfig.dart';
import 'package:flutter/material.dart';
import 'UserRegis.dart'; 
import 'package:http/http.dart' as http;

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    // Load saved email and password if "Remember Me" was selected previously
    _loadRememberMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Color.fromRGBO(200, 242, 255, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email TextField
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                  maxLength: 30,
                ),
              ),

              // Password TextField
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                  maxLength: 30,
                ),
              ),

              // "Remember Me" Checkbox
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value!;
                        _saveRememberMe();
                      });
                    },
                  ),
                  Text('Remember Me'),
                ],
              ),

              SizedBox(height: 16),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Add your login logic here
                  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                    // Display a message if email or password is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Email and password are required.')),
                    );
                  } else if (!isValidEmail(emailController.text)) {
                    // Display a message if email format is invalid
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid email format.')),
                    );
                  } else {
                    _userlogin(context);
                  }
                },
                child: Text('Login'),
              ),

              SizedBox(height: 16),

              // Row for "Forgot password" and "Don't have an account?"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserRegistrationPage()), // Navigate to UserRegis.dart
                      );
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: TextStyle(fontSize: 13),
                    ),
                    child: Text("Don't have an account?"),
                  ),
                  
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()), // Navigate to ForgotPass.dart
                      );
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: TextStyle(fontSize: 13),
                    ),
                    child: Text('Forgot password?'),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        emailController.text = prefs.getString('email') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  // Save "Remember Me" state, email, and password
  void _saveRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', rememberMe);
    if (rememberMe) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    } else {
      prefs.remove('email');
      prefs.remove('password');
    }
  }

  bool isValidEmail(String email) {
    String emailRegex = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  void _userlogin(BuildContext context){
    String _email = emailController.text;
    String _password = passwordController.text;

  

    http.post(
        Uri.parse("${ServerConfig.server}/bookbytes/php/userlogin.php"),
        body: {"email": _email, "password": _password}).then((response) {
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          User user = User.fromJson(data['data']);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Login Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.push(context,
              MaterialPageRoute(builder: (content) =>  MainPage(userdata:user)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Login Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });

  }

}





