import 'package:bookbytes/shared/ServerConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'UserLogin.dart';

class UserRegistrationPage extends StatefulWidget {
  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  bool _termsAndConditionsAccepted = false;
  late String _eulaContent; 
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _confirmPasswordController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _contactController = TextEditingController();
  late TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEULA();
  }

  void _loadEULA() async {
    
    final eulaPath = 'assets/eula.txt'; 
    _eulaContent = await rootBundle.loadString(eulaPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration Details',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Color.fromRGBO(200, 242, 255, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30), // Limit to 30 characters
                ],
              ),
              TextField(
                controller: _contactController,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Contact',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only digits
                  LengthLimitingTextInputFormatter(15), // Limit to 15 characters
                ],
              ),
              TextField(
                controller: _usernameController,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30), // Limit to 30 characters
                ],
              ),
              TextField(
                controller: _passwordController,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
                obscureText: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30), // Limit to 30 characters
                ],
              ),
              TextField(
                controller: _confirmPasswordController,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
                obscureText: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30), // Limit to 30 characters
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Checkbox(
                    value: _termsAndConditionsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _termsAndConditionsAccepted = value ?? false;
                      });
                    },
                  ),
                  Text(
                    'I hereby agree to the ',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _showEULADialog(context);
                    },
                    child: Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  _registerUser();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(200, 242, 255, 1),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _showEULADialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Terms and Conditions',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Text(
              _eulaContent,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(200, 242, 255, 1),
              ),
              child: Text(
                'Close',
                style: TextStyle(fontSize: 14.0,color: Colors.blueGrey),
              ),
            ),
          ],
        );
      },
    );
  }

 
  bool _isValidEmailFormat() {
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(_emailController.text);
  }


  bool _isPasswordConfirmed() {
    return _passwordController.text == _confirmPasswordController.text;
  }


  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }


  void _showSuccessMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Successful'),
          content: Text('You have successfully registered.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserLoginPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(200, 242, 255, 1),
              ),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to register the user
  void _registerUser(){
    String _email = _emailController.text;
    String _contact= _contactController.text;
    String _username = _usernameController.text;
    String _password = _passwordController.text;

    // Validate user data
    if (_email.isEmpty) {
    _showErrorMessage('Email is required.');
    return;
  } else if (_contact.isEmpty) {
    _showErrorMessage('Contact is required.');
    return;
  } else if (_username.isEmpty) {
    _showErrorMessage('Username is required.');
    return;
  } else if (_password.isEmpty) {
    _showErrorMessage('Password is required.');
    return;
  } else if (!_isValidEmailFormat()) {
    _showErrorMessage('Please enter a valid email.');
    return;
  } else if (!_isPasswordConfirmed()) {
    _showErrorMessage('Confirm password does not match.');
    return;
  } else if (!_termsAndConditionsAccepted) {
    _showErrorMessage('You must accept the terms and conditions to register.');
    return;
  }

    http.post(
    Uri.parse('${ServerConfig.server}/bookbytes/php/register.php'), 
    body: {
      'email': _email,
      'contact': _contact,
      'username': _username,
      'password': _password,
    },).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration Success"),
            backgroundColor: Colors.green,
          ));
          _showSuccessMessage();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });

  }
}
  













