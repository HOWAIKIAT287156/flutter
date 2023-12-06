import 'package:bookbytes/Pages/UserLogin.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(200, 242, 255, 1), // Adjust the color for the whole background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      'Navigation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0, // Adjust the font size
                        color: Colors.blueGrey, // Adjust the color
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.black, // Adjust the color
                    onPressed: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                ],
              ),
            ),
            UserAccountsDrawerHeader(
              accountName: Text('Guest'), // Replace with the user's name
              accountEmail: Text('Email'), // Replace with the user's email
              currentAccountPicture: CircleAvatar(
                // Add user image here
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.blueGrey, // Adjust the color
                ),
              ),
            ),
            ListTile(
              title: Text(
                'User Login',
                style: TextStyle(
                  color: Colors.blueGrey, // Set the color of the text
                  fontSize: 16.0, // Adjust the font size
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserLoginPage()),
                );
              },
            ),
            // Add more drawer items as needed
          ],
        ),
      ),
    );
  }
}






