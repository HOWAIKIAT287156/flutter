import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Center( // This widget centers its child within itself.
        child: Text(
          'This feature is under development, please stay tuned!',
          textAlign: TextAlign.center, // Ensures text is centered if it wraps to a new line.
          style: TextStyle(fontSize: 16), // Optional: Adjusts the font size for visibility.
        ),
      ),
    );
  }
}


