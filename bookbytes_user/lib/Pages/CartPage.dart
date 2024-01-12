import 'dart:convert';

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
    @override
    void initState() {
      super.initState();
      loadUserCart();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(200, 242, 255, 1), // AppBar color
        iconTheme: IconThemeData(color: Colors.blueGrey),
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.blueGrey), // Apply the color to the text
        ),
      ),
      body: cartList.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : Column(children: [
              Expanded(
                child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                          child: Row(children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.update))
                          ]),
                        ),
                        key: Key(cartList[index].bookId.toString()),
                        child: ListTile(
                            title: Text(cartList[index].bookTitle.toString()),
                            onTap: () async {},
                            subtitle: Text("RM ${cartList[index].bookPrice}"),
                            leading: const Icon(Icons.sell),
                            trailing:
                                Text("x ${cartList[index].cartQty} unit")),
                      );
                    }),
              ),
              Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TOTAL RM ${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Pay Now"))
                    ],
                  ))
            ]),
    );
  }

  void loadUserCart() {
    String userid = widget.userdata.userid.toString();
    http
        .get(
      Uri.parse(
          "${ServerConfig.server}/bookbytes/php/loadCart.php?userid=$userid"),
    )
        .then((response) {
      if (response.statusCode == 200) {
        // log(response.body);
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          cartList.clear();
          total = 0.0;
          data['data']['carts'].forEach((v) {
            cartList.add(Cart.fromJson(v));

            // Parse the values before performing arithmetic operations
            double bookPrice = double.parse(v['book_price']);
            int cartQty = int.parse(v['cart_qty']);

            total += bookPrice * cartQty;
          });
          print(total);
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
}





