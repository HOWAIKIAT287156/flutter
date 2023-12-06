import 'package:flutter/material.dart';

class UserRegistrationPage extends StatelessWidget {
  bool _termsAndConditionsAccepted = false;

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Contact',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Show terms and conditions pop-up
                  _showTermsAndConditionsDialog(context);
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

  // Function to show the terms and conditions pop-up
  void _showTermsAndConditionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Terms and Conditions',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text('Please read the '),
                    TextButton(
                      onPressed: () {
                        // Handle tap on "Terms and Conditions" button
                        // You can navigate to a separate page or perform other actions
                      },
                      child: Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Checkbox(
                      value: _termsAndConditionsAccepted,
                      onChanged: (value) {
                        // Handle checkbox state change
                        _termsAndConditionsAccepted = value ?? false;
                      },
                    ),
                    Text(
                      'I hereby agree to the terms and conditions',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.all(16.0), // Adjust padding for content
          actions: [
            ElevatedButton(
              onPressed: () {
                // Handle registration logic here
                if (_termsAndConditionsAccepted) {
                  // Proceed with registration
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  // Show a message indicating that terms must be accepted
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please agree to the terms and conditions.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(200, 242, 255, 1),
              ),
              child: Text(
                'Register',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(200, 242, 255, 1),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        );
      },
    );
  }
}






