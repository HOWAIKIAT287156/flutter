import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController numa = TextEditingController();
  TextEditingController numb = TextEditingController();
  double vala = 0.0, valb = 0.0, result = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("MY Calculator")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              TextField(
                controller: numa,
                decoration: InputDecoration(
                    hintText: "Enter your first number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                keyboardType: const TextInputType.numberWithOptions(),
              ),
              const SizedBox(height: 8,),
              TextField(
                controller: numb,
                 decoration: InputDecoration(
                    hintText: "Enter your second number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                keyboardType: const TextInputType.numberWithOptions(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: onPlus,
                      child: const Text("+", style: TextStyle(fontSize: 16))),
                  ElevatedButton(
                      onPressed: onMinus,
                      child: const Text("-", style: TextStyle(fontSize: 16))),
                  ElevatedButton(
                      onPressed: onMult,
                      child: const Text("x", style: TextStyle(fontSize: 16))),
                  ElevatedButton(
                      onPressed: onDiv,
                      child: const Text("/", style: TextStyle(fontSize: 16))),
                ],
              ),
              Text(
                "Output: $result",
                style: const TextStyle(fontSize: 24),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void onPlus() {
    vala = double.parse(numa.text);
    valb = double.parse(numb.text);
    result = vala + valb;
    setState(() {});
  }

  void onMinus() {
    vala = double.parse(numa.text);
    valb = double.parse(numb.text);
    result = vala - valb;
    setState(() {});
  }

  void onMult() {
    vala = double.parse(numa.text);
    valb = double.parse(numb.text);
    result = vala * valb;
    setState(() {});
  }

  void onDiv() {
    vala = double.parse(numa.text);
    valb = double.parse(numb.text);
    result = vala / valb;
    setState(() {});
  }
}