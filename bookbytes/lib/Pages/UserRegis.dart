import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bookbytes/model/config.dart';
import 'UserLogin.dart';

class UserRegistrationPage extends StatefulWidget {
  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  bool _termsAndConditionsAccepted = false;
  late String _eulaContent; // Variable to store the EULA content
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    // Load the EULA content when the widget is initialized
    _loadEULA();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _emailController = TextEditingController();
    _contactController = TextEditingController();  // Initialize _contactController
    _usernameController = TextEditingController();
  }

  Future<void> _loadEULA() async {
    // Use rootBundle to load the EULA content from the assets file
    final eulaPath = 'assets/eula.txt'; // Update the path to your EULA file
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
      body: Center(
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
                      // Show the EULA content in a dialog when the button is pressed
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

  // Function to show the EULA content in a dialog
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
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to validate email format
  bool _isValidEmailFormat() {
    // Use a regular expression to check for a valid email format
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(_emailController.text);
  }

  // Function to check if password and confirm password match
  bool _isPasswordConfirmed() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  // Function to show a SnackBar with the provided message
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Function to show a success message
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
  Future<void> _registerUser() async {
    // Validate user data
    if (!_isValidEmailFormat()) {
      _showErrorMessage('Please enter a valid email.');
      return;
    } else if (!_isPasswordConfirmed()) {
      _showErrorMessage('Confirm password is different from Password.');
      return;
    } else if (!_termsAndConditionsAccepted) {
      _showErrorMessage('Registration requires your agreement.');
      return;
    }

    // Proceed to register user if data is valid
    try {
      final response = await http.post(
        Uri.parse('${Config.server}/server/register.php'), // Replace with your server URL
        body: {
          'email': _emailController.text,
          'contact': _contactController.text,
          'username': _usernameController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          _showSuccessMessage();
        } else {
          _showErrorMessage(result['message']);
        }
      } else {
        _showErrorMessage('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorMessage('Error: $e');
    }
  }
}













