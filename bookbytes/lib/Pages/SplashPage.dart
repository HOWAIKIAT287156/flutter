import 'package:flutter/material.dart';
import 'MainPage.dart'; // Import the main page

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 3 seconds before navigating to the main page
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Your splash screen UI code goes here
    return Scaffold(
      backgroundColor: Color.fromRGBO(200, 242, 255, 1), // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg', // Adjust the path based on your project structure
              height: 200, // Adjust the height of the image
              width: 200, // Adjust the width of the image
            ),
            SizedBox(height: 20), // Add some space between image and text
            Text(
              'BookBytes',
              style: TextStyle(
                color: Colors.blue, // Set the text color
                fontSize: 24, // Set the text size
                fontWeight: FontWeight.bold, // Set the text weight
              ),
            ),
            SizedBox(height: 20), // Add some space between text and loading indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey), // Set the loading icon color
            ),
            SizedBox(height: 10), // Add some space between loading indicator and text
            Text(
              'Good Things Take Time',
              style: TextStyle(
                color: Colors.blue, // Set the text color
                fontSize: 16, // Set the text size
              ),
            ),
          ],
        ),
      ),
    );
  }
}




