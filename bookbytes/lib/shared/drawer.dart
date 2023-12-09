import 'package:bookbytes/Pages/GuestProfilePage.dart';
import 'package:bookbytes/Pages/UserLogin.dart';
import 'package:bookbytes/Pages/UserProfilePage.dart';
import 'package:bookbytes/models/user.dart';
import 'package:flutter/material.dart';


class AppDrawer extends StatefulWidget {
  final String page;
  final User userdata;

  const AppDrawer({Key? key, required this.page, required this.userdata})
      : super(key: key);

  @override
  State<AppDrawer> createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            currentAccountPicture: const CircleAvatar(
                foregroundImage: AssetImage('assets/images/guest.jpg'),
                backgroundColor: Colors.white),
            accountName: Text(widget.userdata.username.toString()),
            accountEmail: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.userdata.useremail.toString()),
                ],
              ),
            ),
            // Add this part for the back button
            otherAccountsPictures: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    // Close the drawer
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('User Profile'),
            onTap: () {
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
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favourite'),
            onTap: () => _showDevelopingMessage(),
          ),

          // Setting ListTile
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            onTap: () => _showDevelopingMessage(),
          ),

          // Help Center ListTile
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help Center'),
            onTap: () => _showDevelopingMessage(),
          ),

          // Terms & Conditions / Privacy ListTile
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Terms & Conditions / Privacy'),
            onTap: () => _showDevelopingMessage(),
          ),

          // ... (Any other ListTiles you have)
        ],
      ),
    );
  }
  void _showDevelopingMessage() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("This feature is still developing, stay tuned!"),
      ),
    );
  }
}






