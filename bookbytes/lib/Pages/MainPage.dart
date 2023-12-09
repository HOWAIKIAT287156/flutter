import 'package:bookbytes/models/user.dart';
import 'package:bookbytes/shared/drawer.dart';
import 'package:flutter/material.dart';

import 'CartPage.dart';
import 'UserProfilePage.dart';
import 'GuestProfilePage.dart'; // Import the GuestProfilePage

class MainPage extends StatefulWidget {
  final User userdata;
  const MainPage({super.key, required this.userdata});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BookBytes',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Color.fromRGBO(200, 242, 255, 1),
      ),
      drawer: AppDrawer(
        page: "books",
        userdata: widget.userdata,
      ),
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
            padding: EdgeInsets.all(12.0),
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
                       MaterialPageRoute(builder: (context) => CartPage()),
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
                      if (widget.userdata.useremail == "guest@gmail.com" &&
                          widget.userdata.username == "Guest") {
                        // Navigate to GuestProfilePage if conditions match
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GuestProfilePage(userdata: widget.userdata),
                          ),
                        );
                      } else {
                        // Navigate to UserProfilePage for other users
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserProfilePage(userdata: widget.userdata),
                          ),
                        );
                      }
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















