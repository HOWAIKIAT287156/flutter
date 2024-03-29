import 'package:bookbytes/Pages/CartPage.dart';
import 'package:bookbytes/Pages/MainPage.dart';
import 'package:bookbytes/Pages/UserLogin.dart';
import 'package:bookbytes/Pages/UserRegis.dart';
import 'package:bookbytes/shared/drawer.dart';
import 'package:flutter/material.dart';
import 'package:bookbytes/models/user.dart';

class GuestProfilePage extends StatefulWidget {
  final User userdata;

  GuestProfilePage({required this.userdata});

  @override
  _GuestProfilePageState createState() => _GuestProfilePageState();
}

class _GuestProfilePageState extends State<GuestProfilePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueGrey),
        title: Text('User Profile',
        style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Color.fromRGBO(200, 242, 255, 1),
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
            Row(
              children: [
                SizedBox(width: 110.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserLoginPage(),
                      ),
                    );
                  },
                  child: Text('Sign In',
                  style: TextStyle(color: Colors.blueGrey),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(200, 242, 255, 1), // Button color
                  ),
                ),
                SizedBox(width: 12.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserRegistrationPage(),
                      ),
                    );
                  },
                  child: Text('Sign Up',
                  style: TextStyle(color: Colors.blueGrey),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(200, 242, 255, 1), // Button color
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/guest.jpg'),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(width: 30.0),
                Icon(Icons.email),
                SizedBox(width: 16.0),
                Text('Email: ${widget.userdata.useremail}'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(width: 30.0),
                Icon(Icons.person),
                SizedBox(width: 16.0),
                Text('Name: ${widget.userdata.username}'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(width: 30.0),
                Icon(Icons.phone),
                SizedBox(width: 16.0),
                Text('Contact: ${widget.userdata.usercontact}'),
              ],
            ),
            
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
                Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => CartPage(userdata:widget.userdata)),
                       );
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: Colors.grey,
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
