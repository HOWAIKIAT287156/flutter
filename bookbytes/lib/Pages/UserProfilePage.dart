import 'package:bookbytes/Pages/CartPage.dart';
import 'package:flutter/material.dart';
import 'MainPage.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(
          'User Profile',
          style: TextStyle(color: Colors.blueGrey), // Set the color of the text
        ),
        backgroundColor: Color.fromRGBO(200, 242, 255, 1),
      ),
      body: Center(
        child: Text('User Profile Page Content'),
      ),
      bottomNavigationBar: ContainerWithIcons(),
    );
  }
}

class ContainerWithIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.0),
      color: Color.fromRGBO(200, 242, 255, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 50.0,
            height: 40.0,
            child: IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.black, // Set the color to grey
              ),
              iconSize: 40.0,
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()), // Navigate to UserProfilePage
                );
              },
            ),
          ),
          SizedBox(
            width: 60.0,
            height: 50.0,
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black, // Set the color to blue
              ),
              iconSize: 50.0,
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()), // Navigate to UserProfilePage
                );
              },
            ),
          ),
          SizedBox(
            width: 60.0,
            height: 40.0,
            child: IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey, // Set the color to green
              ),
              iconSize: 40.0,
              onPressed: () {
                // Handle user profile button press
              },
            ),
          ),
        ],
      ),
    );
  }
}




