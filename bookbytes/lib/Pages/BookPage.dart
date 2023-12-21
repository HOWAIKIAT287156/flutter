import 'package:bookbytes/Pages/UserLogin.dart';
import 'package:bookbytes/models/book.dart';
import 'package:bookbytes/models/user.dart';
import 'package:bookbytes/shared/ServerConfig.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  final User user;
  final Book book;

  const BookPage({super.key, required this.user, required this.book});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late double screenWidth, screenHeight;
  final f = DateFormat('dd-MM-yyyy hh:mm a');

  

  @override
  Widget build(BuildContext context) {
   
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueGrey),
        backgroundColor: Color.fromRGBO(200, 242, 255, 1), // Set the background color
        title: Text(widget.book.bookTitle.toString(),style: TextStyle(color: Colors.blueGrey),),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: screenHeight * 0.4,
            width: screenWidth,
            //  padding: const EdgeInsets.all(4.0),
            child: Image.network(
                fit: BoxFit.fill,
                "${ServerConfig.server}/bookbytes/assets/books/${widget.book.bookId}.png"),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            height: screenHeight * 0.6,
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  widget.book.bookTitle.toString(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                widget.book.bookAuthor.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                  "Date Available ${f.format(DateTime.parse(widget.book.bookDate.toString()))}"),
              Text("ISBN ${widget.book.bookIsbn}"),
              const SizedBox(
                height: 8,
              ),
              Text(widget.book.bookDesc.toString(),
                  textAlign: TextAlign.justify),
              Text(
                "RM ${widget.book.bookPrice}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("Quantity Available ${widget.book.bookQty}"),
            ]),
          ),
        ]),
      ),
      bottomNavigationBar: buildFooter(), // Add the footer here
    );
  }
Widget buildFooter() {
    return BottomAppBar(
      color: Color.fromRGBO(200, 242, 255, 1),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
              // Verify user before adding to cart
              if (widget.user.useremail == "guest@gmail.com" && widget.user.username == "Guest") {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Login Required'),
                      content: Text('Please log in to add items to your cart.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Login'),
                          onPressed: () {
                            // Navigate to UserLoginPage
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserLoginPage()));
                          },
                        ),
                        TextButton(
                          child: Text('No, thanks'),
                          onPressed: () {
                            // Close the dialog
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                // Add to Cart functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Added Successfully! Go to your Cart to place order!!!"))
                );
              }
            },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15), // Add padding for larger button
                child: Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white, fontSize: 20), // Larger text
                ),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("This feature is unavailable yet. Stay tuned!"))
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15), // Add padding for larger button
                child: Text(
                  'Place Order',
                  style: TextStyle(color: Colors.white, fontSize: 20), // Larger text
                ),
              ),
              style: TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 204, 51, 54)),
            ),
          ),
        ],
      ),
    );
  }
}