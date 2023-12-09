import 'package:flutter/material.dart';
import 'Pages/SplashPage.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookBytes',
      home: SplashPage(), 
    );
  }
}
