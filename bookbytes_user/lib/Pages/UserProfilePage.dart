import 'package:bookbytes/Pages/CartPage.dart';
import 'package:bookbytes/Pages/MainPage.dart';
import 'package:bookbytes/shared/drawer.dart';
import 'package:flutter/material.dart';
import 'package:bookbytes/models/user.dart';


class UserProfilePage extends StatefulWidget {
  final User userdata;

  UserProfilePage({required this.userdata});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  
  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                _logout(); 
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
  
  void _logout() {
 
  User guestUserData = User(
    userid: "0",
    useremail: "guest@gmail.com",
    usercontact: "###",
    username: "Guest",
    userdate: "",
    userpassword: "",
  );

  
  Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => MainPage(userdata: guestUserData)),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueGrey),
        title: Text('User Profile',
        style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Color.fromRGBO(200, 242, 255, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.blueGrey, 
            ),
            onPressed: _confirmLogout,
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
            // IconButton(
            //   icon: Icon(Icons.shopping_cart),
            //   iconSize: 50.0,
            //   onPressed: () {
            //     Navigator.push(
            //            context,
            //            MaterialPageRoute(builder: (context) => CartPage(userdata:widget.userdata)),
            //            );
            //   },
            // ),
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



















