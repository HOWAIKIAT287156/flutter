import 'package:bookbytes/shared/drawer.dart';
import 'package:flutter/material.dart';

import 'CartPage.dart';
import 'UserProfilePage.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(
          'BookBytes',
          style: TextStyle(color: Colors.blueGrey), // Set the color of the text
        ),
        backgroundColor: Color.fromRGBO(200, 242, 255, 1),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          // Main Page Content
          Expanded(
            child: Center(
              child: Text('Main Page Content'),
            ),
          ),
          // Container with Icon Buttons at the bottom
          Container(
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
                      color: Colors.grey,
                    ),
                    iconSize: 40.0,
                    onPressed: () {
                      // Handle home button press
                    },
                  ),
                ),
                SizedBox(
                  width: 60.0,
                  height: 50.0,
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    iconSize: 50.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()), // Navigate to CartPage
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 60.0,
                  height: 40.0,
                  child: IconButton(
                    icon: Icon(Icons.person),
                    iconSize: 40.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfilePage()), // Navigate to UserProfilePage
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}













