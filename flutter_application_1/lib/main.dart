import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); //main class
}

class MyApp extends StatefulWidget {
  const MyApp({super.key}); //Constructor

  @override
  State<MyApp>createState() => MyAppState();

}
  // This widget is the root of your application.
  class MyAppState extends State<MyApp> {
  String name = "THOMAS";

 @override
  Widget build(BuildContext context) { //all UI here
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: const Text("hello"),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
        Text(name),
        MaterialButton(
          onPressed: pressMe,
         
          color: Colors.yellow,
          child: const Text("Press me"),
          )
      ],
        ),
      )));
    
    }
    void pressMe() {
      {name="haha";
          print(name);
          setState(() {});
        
    }
  }
  
