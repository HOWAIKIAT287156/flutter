import 'dart:convert';

import 'package:bookbytes/Pages/PaymentPage.dart';
import 'package:bookbytes/models/cart.dart';
import 'package:bookbytes/models/user.dart';
import 'package:bookbytes/shared/ServerConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final User userdata;

  const CartPage({super.key, required this.userdata});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> cartList = <Cart>[];
  double total = 0.0;
  int totalQuantity = 0;

  @override
  void initState() {
    super.initState();
    loadUserCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(200, 242, 255, 1),
        iconTheme: IconThemeData(color: Colors.blueGrey),
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
      body: cartList.isEmpty
              ? const Center(
                  child: Text("Your cart is empty."),
                )
    
          : Column(children: [
              Text(
                "Swipe right to remove item",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                      ),
                      key: Key(cartList[index].bookId.toString()),
                      child: ListTile(
                        leading: Image.network(
                          "${ServerConfig.server}/bookbytes/assets/books/${cartList[index].bookId}.png",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(cartList[index].bookTitle.toString()),
                        
                        subtitle: 
                        Row(
                          children: [
                            Text("RM ${cartList[index].bookPrice}"),
                            SizedBox(width: 140),
                            IconButton(
                              icon: Icon(Icons.remove, size: 20),
                              onPressed: () {
                                String cartnum = cartList[index].cartQty.toString();
                                int currentQty = int.parse(cartnum);
                                  if (currentQty > 1) {
                                    _decrCart(index);
                                  } else {
                                    // If cartQty is already 1, prompt user for deletion confirmation
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Confirm Deletion"),
                                          content: Text("Are you sure you want to remove this item from your cart?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(false),
                                              child: Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // User confirmed deletion, proceed with calling deleteCart.php
                                                _decrCart(index); // Update to cartQty 0 for deletion
                                                Navigator.of(context).pop(true);
                                              },
                                              child: Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                              },
                            ),

                            SizedBox(width: 1),
                            Text(cartList[index].cartQty.toString()), // Display the quantity
                            SizedBox(width: 1),
                            IconButton(
                              icon: Icon(Icons.add, size: 20),
                              onPressed: () {
                                _incrCart(index);
                              },
                            ),
                          ],
                        ),
                        onTap: () async {},
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirm Deletion"),
                              content: Text("Are you sure you want to remove this item from your cart?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          // User confirmed deletion, proceed with calling deleteCart.php
                          String cartId = cartList[index].cartId.toString();

                          // Make an HTTP request to deleteCart.php
                          http.post(
                            Uri.parse("${ServerConfig.server}/bookbytes/php/deleteCart.php"),
                            body: {
                              "cart_id": cartId,
                            },
                          ).then((response) {
                            // Check if the deletion was successful
                            if (response.statusCode == 200) {
                              var data = jsonDecode(response.body);
                              if (data['status'] == "success") {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(data['message']),
                                  duration: Duration(seconds: 2),
                                ));
                                // Deletion successful, reload the cart
                                loadUserCart();
                              } else {
                                // Deletion failed, show an error message
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(data['message']),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            } else {
                              // Server error, show an error message
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Server error. Please try again later."),
                                duration: Duration(seconds: 2),
                              ));
                            }
                          });
                        }
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TOTAL RM ${total.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentPage(
                                  userdata: widget.userdata,
                                  totalprice: total,
                                ),
                              ),
                            );
                          },
                          child: const Text("Pay Now"),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Total items: $totalQuantity",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            ]),
    );
  }

  void loadUserCart() {
    String userid = widget.userdata.userid.toString();
    http.get(
      Uri.parse("${ServerConfig.server}/bookbytes/php/loadCart.php?userid=$userid"),
    ).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          cartList.clear();
          total = 0.0;
          totalQuantity = 0;
          data['data']['carts'].forEach((v) {
            cartList.add(Cart.fromJson(v));

            double bookPrice = double.tryParse(v['book_price']) ?? 0.0;
            int cartQty = int.tryParse(v['cart_qty']) ?? 0;

            total += bookPrice * cartQty;
            totalQuantity += cartQty;
          });
          setState(() {});
        } else {
          Navigator.of(context).pop();
          //if no status failed
        }
      }
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      print("Timeout");
    });
  }

  void _decrCart(int index) {
  String cartId = cartList[index].cartId.toString();

      http.post(
        Uri.parse("${ServerConfig.server}/bookbytes/php/minusCart.php"),
        body: {
          "cart_id": cartId,
        },
      ).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['status'] == "success") {
            loadUserCart();
          } else {
            // Update failed, show an error message
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(data['message']),
              duration: Duration(seconds: 2),
            ));
          }
        } else {
          // Server error, show an error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Server error. Please try again later."),
            duration: Duration(seconds: 2),
          ));
        }
      });
  }

  void _incrCart(int index) {
  String cartId = cartList[index].cartId.toString();

      http.post(
        Uri.parse("${ServerConfig.server}/bookbytes/php/plusCart.php"),
        body: {
          "cart_id": cartId,
        },
      ).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['status'] == "success") {
            loadUserCart();
          } else {
            // Update failed, show an error message
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(data['message']),
              duration: Duration(seconds: 2),
            ));
          }
        } else {
          // Server error, show an error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Server error. Please try again later."),
            duration: Duration(seconds: 2),
          ));
        }
      });
  }

}






