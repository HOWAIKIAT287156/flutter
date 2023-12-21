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
        title: Text(widget.book.bookTitle.toString()),
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
    );
  }
}