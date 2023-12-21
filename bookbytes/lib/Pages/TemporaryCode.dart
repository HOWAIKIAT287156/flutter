// Container(
//             padding: EdgeInsets.all(12.0),
//             color: Color.fromRGBO(200, 242, 255, 1),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   width: 50.0,
//                   height: 40.0,
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.home,
//                       color: Colors.grey,
//                     ),
//                     iconSize: 40.0,
//                     onPressed: () {
//                       // Handle home button press
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   width: 60.0,
//                   height: 50.0,
//                   child: IconButton(
//                     icon: Icon(Icons.shopping_cart),
//                     iconSize: 50.0,
//                     onPressed: () {
//                        Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => CartPage()),
//                        );
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   width: 60.0,
//                   height: 40.0,
//                   child: IconButton(
//                     icon: Icon(Icons.person),
//                     iconSize: 40.0,
//                     onPressed: () {
//                       if (widget.userdata.useremail == "guest@gmail.com" &&
//                           widget.userdata.username == "Guest") {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => GuestProfilePage(userdata: widget.userdata),
//                           ),
//                         );
//                       } else {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 UserProfilePage(userdata: widget.userdata),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),