import 'package:flutter/material.dart';
import 'Pages/SplashPage.dart'; // Import the splash page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookBytes',
      home: SplashPage(), // Start with the splash page
    );
  }
}
