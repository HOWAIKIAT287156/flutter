import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueGrey),
        title: Text('Shopping Cart',
        style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Color.fromRGBO(200, 242, 255, 1),
      ),
      body: Center(
        child: Text(
          'This feature is unavailable now, stay tuned!',
          style: TextStyle(
            fontSize: 15.0, 
            fontWeight: FontWeight.bold, 
          ),
        ),
      ),
    );
  }
}





