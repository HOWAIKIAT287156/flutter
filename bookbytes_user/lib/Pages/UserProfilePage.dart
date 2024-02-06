import 'dart:convert';

import 'package:bookbytes/Pages/CartPage.dart';
import 'package:bookbytes/Pages/MainPage.dart';
import 'package:bookbytes/shared/ServerConfig.dart';
import 'package:bookbytes/shared/drawer.dart';
import 'package:flutter/material.dart';
import 'package:bookbytes/models/user.dart';
import 'package:http/http.dart' as http;


class UserProfilePage extends StatefulWidget {
  final User userdata;

  UserProfilePage({required this.userdata});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
   late double screenHeight, screenWidth, resWidth;
  
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

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage(userdata: guestUserData)),
    );
  }



  @override
Widget build(BuildContext context) {
  screenHeight = MediaQuery.of(context).size.height; 
  screenWidth = MediaQuery.of(context).size.width; 

  return Scaffold(
    appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.blueGrey),
      title: Text(
        'User Profile',
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
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.0),
            Center(
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage("${ServerConfig.server}/bookbytes/assets/profile/${widget.userdata.userid}.jpeg"),
            ),
          ),
            SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(width: 30.0),
                Icon(Icons.email),
                SizedBox(width: 16.0),
                Text('Email: ${widget.userdata.useremail}'),
                IconButton(
                  icon: Icon(Icons.edit),
                  tooltip: 'Edit Password', 
                  onPressed: _editPassword,
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(width: 30.0),
                Icon(Icons.person),
                SizedBox(width: 16.0), 
                Text('Name: ${widget.userdata.username}'),
                IconButton(
                  icon: Icon(Icons.edit),
                  tooltip: 'Edit Username', 
                  onPressed: _editUsername,
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(width: 30.0),
                Icon(Icons.phone),
                SizedBox(width: 16.0), 
                Text('Contact: ${widget.userdata.usercontact}'),
                IconButton(
                  icon: Icon(Icons.edit),
                  tooltip: 'Edit Contact', 
                  onPressed: _editContact,
                ),
              ],
            ),
            
          ],
        ),
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
              Navigator.push(context, MaterialPageRoute(builder: (content) =>  MainPage(userdata:widget.userdata)));
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

  void _editUsername() {
  TextEditingController _nameeditingController = TextEditingController();
  _nameeditingController.text = widget.userdata.username.toString();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: const Text(
          "Name",
          style: TextStyle(),
        ),
        content: TextField(
            controller: _nameeditingController,
            keyboardType: TextInputType.name),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Confirm",
              style: TextStyle(),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              http.post(
                  Uri.parse("${ServerConfig.server}/bookbytes/php/update_profile.php"),
                  body: {
                    "name": _nameeditingController.text,
                    "userid": widget.userdata.userid
                  }).then((response) {
                var data = jsonDecode(response.body);
                if (response.statusCode == 200) {
                  if (data['status'] == "success") {
                  print(data);
                  setState(() {
                    widget.userdata.username = _nameeditingController.text;
                  });
                  _showMessage("Username updated successfully");
                } else {
                  _showMessage("Failed to update username");
                }
              }
            });
            },
          ),
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _editContact() {
  TextEditingController _phoneeditingController = TextEditingController();
  _phoneeditingController.text = widget.userdata.usercontact.toString();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: const Text(
          "Phone Number",
          style: TextStyle(),
        ),
        content: TextField(
            controller: _phoneeditingController,
            keyboardType: TextInputType.phone),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Confirm",
              style: TextStyle(),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              http.post(
                  Uri.parse("${ServerConfig.server}/bookbytes/php/update_profile.php"),
                  body: {
                    "phone": _phoneeditingController.text,
                    "userid": widget.userdata.userid
                  }).then((response) {
                var data = jsonDecode(response.body);
                if (response.statusCode == 200 && data['status'] == 'success') {
                  setState(() {
                    widget.userdata.usercontact = _phoneeditingController.text;
                  });
                  _showMessage("Contact updated successfully");
                } else {
                  _showMessage("Failed to update contact");
                }
              });
            },
          ),
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _editPassword() {
  TextEditingController _pass1editingController = TextEditingController();
  TextEditingController _pass2editingController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: const Text(
          "Update Password",
          style: TextStyle(),
        ),
        content: SizedBox(
          height: screenHeight / 5,
          child: Column(
            children: [
              TextField(
                  controller: _pass1editingController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'New password',
                      labelStyle: TextStyle(),
                      icon: Icon(
                        Icons.password,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ))),
              TextField(
                  controller: _pass2editingController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Re-enter password',
                      labelStyle: TextStyle(),
                      icon: Icon(
                        Icons.password,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ))),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Confirm",
              style: TextStyle(),
            ),
            onPressed: () {
              if (_pass1editingController.text !=
                  _pass2editingController.text) {
                _showMessage("Passwords do not match");
                return;
              }
              if (_pass1editingController.text.isEmpty ||
                  _pass2editingController.text.isEmpty) {
                _showMessage("Please enter a password");
                return;
              }
              Navigator.of(context).pop();
              http.post(
                  Uri.parse("${ServerConfig.server}/bookbytes/php/update_profile.php"),
                  body: {
                    "password": _pass1editingController.text,
                    "userid": widget.userdata.userid
                  }).then((response) {
                var data = jsonDecode(response.body);
                if (response.statusCode == 200 && data['status'] == 'success') {
                  _showMessage("Password updated successfully");
                } else {
                  _showMessage("Failed to update password");
                }
              });
            },
          ),
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showMessage(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}

}






















