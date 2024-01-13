import 'package:bookbytes/Pages/UserLogin.dart';
import 'package:bookbytes/models/book.dart';
import 'package:bookbytes/models/user.dart';
import 'package:bookbytes/shared/ServerConfig.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

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
  bool bookowner = false;

  

  @override
  Widget build(BuildContext context) {
    if (widget.user.userid == widget.book.userId) {
      bookowner = true;
    } else {
      bookowner = false;
    }
   
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
                if (widget.book.bookQty != "0"){
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
                  } else if(bookowner == true){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Notification'),
                            content: Text("Book owner doesn't have to add into cart."),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  
                  else {
                    insertCartDialog();
                  }

                }else {
                  showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Notification'),
                            content: Text("This book is temporarily unavailable.Please wait for owner to restock."),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
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

  void insertCartDialog() {
  TextEditingController quantityController = TextEditingController();
  String errorMessage = '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        title: Text(
          "How many would you like to add to cart? Maximum ${widget.book.bookQty}",
          style: TextStyle(),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d{1,5}$')),
                ],
                decoration: InputDecoration(
                  labelText: 'Quantity',
                ),
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Add to Cart",
              style: TextStyle(),
            ),
            onPressed: () {
              String bookqty = widget.book.bookQty.toString();
              int booknum = int.parse(bookqty);
              int quantity = int.tryParse(quantityController.text) ?? 0;

              if (quantity > 0 && quantity <= booknum) {
                Navigator.of(context).pop();
                insertCart(quantity);
              } else if (quantity == 0) {
                errorMessage = "Please enter a quantity greater than 0.";
                showErrorMessage(context, errorMessage);
              } else if (quantity > booknum) {
                errorMessage = "Quantity exceeds available stock.";
                showErrorMessage(context, errorMessage);
              } else {
                errorMessage = "Invalid quantity. Please try again.";
                showErrorMessage(context, errorMessage);
              }
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

void showErrorMessage(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        title: Text("Error"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



  void insertCart(int quantity) {
    
    http.post(
        Uri.parse("${ServerConfig.server}/bookbytes/php/addCart.php"),
        body: {
          "buyer_id": widget.user.userid.toString(),
          "seller_id": widget.book.userId.toString(),
          "book_id": widget.book.bookId.toString(),
          "quantity": quantity.toString()
        }).then((response) {
      log(response.body);
        if (response.statusCode == 200) {
          if (response.body.isNotEmpty) {
            var data = jsonDecode(response.body);
            if (data['status'] == "success") {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Add Successfully! Check your cart now!"),
                backgroundColor: Colors.green,
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Failed to add! Your quantity has exceeded the book quantity including your cart!"),
                backgroundColor: Colors.red,
              ));
            }
          }
        }else {
          print(response.statusCode);

        }
      });
  }
}
