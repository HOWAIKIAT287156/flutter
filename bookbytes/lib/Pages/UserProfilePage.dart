import 'package:bookbytes/Pages/MainPage.dart';
import 'package:bookbytes/Pages/UserLogin.dart';
import 'package:bookbytes/shared/drawer.dart';
import 'package:flutter/material.dart';
import 'package:bookbytes/models/user.dart';
// Import additional pages if necessary

class UserProfilePage extends StatefulWidget {
  final User userdata;

  UserProfilePage({required this.userdata});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  
  void _logout() {
  // Reset user data to represent a guest
  User guestUserData = User(
    userid: "0",
    useremail: "guest@gmail.com",
    usercontact: "###",
    username: "Guest",
    userdate: "",
    userpassword: "",
  );

  // Navigate to the MainPage with the new guest user data
  Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => MainPage(userdata: guestUserData)),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout,
          ),
        ],
      ),
      drawer: AppDrawer(
        page: "books",
        userdata: widget.userdata,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.0),
            Center(
              child: CircleAvatar(
                radius: 50.0,
                // You can replace this with the user's actual avatar image
                backgroundImage: AssetImage('assets/images/guest.jpg'),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(width: 30.0),
                Icon(Icons.email),
                SizedBox(width: 16.0), // Increased padding here
                Text('Email: ${widget.userdata.useremail}'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(width: 30.0),
                Icon(Icons.person),
                SizedBox(width: 16.0), // Increased padding here
                Text('Name: ${widget.userdata.username}'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(width: 30.0),
                Icon(Icons.phone),
                SizedBox(width: 16.0), // Increased padding here
                Text('Contact: ${widget.userdata.usercontact}'),
              ],
            ),
            // You can add more user information fields/icons here
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(1.0),
        color: Color.fromRGBO(200, 242, 255, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              iconSize: 40.0,
              onPressed: () {
                Navigator.push(context,
              MaterialPageRoute(builder: (content) =>  MainPage(userdata:widget.userdata)));
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              iconSize: 50.0,
              onPressed: () {
                // Handle shopping cart button press
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              iconSize: 40.0,
              onPressed: () {
                // Handle person icon button press
              },
            ),
          ],
        ),
      ),
    );
  }
}



















