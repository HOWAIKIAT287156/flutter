import 'package:flutter/material.dart';

class MyStatelessWidget extends StatelessWidget {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stateful Widget Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter: $counter'),
          ElevatedButton(
            onPressed: incrementCounter,
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
  
  void setState(Null Function() param0) {}
}

void main() {
  runApp(MaterialApp(
    home: MyStatelessWidget(),
  ));
}