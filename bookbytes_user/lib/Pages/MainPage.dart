import 'dart:convert';
import 'dart:developer';
import 'package:bookbytes/Pages/BookPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:bookbytes/models/user.dart';
import 'package:bookbytes/shared/drawer.dart';
import 'package:bookbytes/models/book.dart';
import 'package:bookbytes/shared/ServerConfig.dart';
import 'CartPage.dart';
import 'UserProfilePage.dart';
import 'GuestProfilePage.dart';

class MainPage extends StatefulWidget {
  final User userdata;
  const MainPage({super.key, required this.userdata});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    List<Book> bookList = <Book>[];
      final TextEditingController searchController = TextEditingController();

      late double screenWidth, screenHeight;
      int numofpage = 1;
      int curpage = 1;
      int numofresult = 0;

      var color;
      String title = "";

      @override
      void initState() {
        super.initState();
        loadBooks(title);
      }

  int axiscount = 2;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(200, 242, 255, 1), // AppBar color
        iconTheme: IconThemeData(color: Colors.blueGrey),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align to the start
          children: [
            // Adjusted width for shorter search bar
            Container(
              width: 220.0, // Adjust width as needed
              height: 40.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController, // Using a TextEditingController
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16.0, bottom: 8.0), // Adjust for vertical centering
                      ),
                      style: TextStyle(height: 1.5), // Adjust for vertical centering
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      loadBooks(searchController.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
          actions: [
            // Add the cart icon button to the right side of the AppBar
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(userdata:widget.userdata)));
              },
            ),
          ],
      ),


      drawer: AppDrawer(
        page: "books",
        userdata: widget.userdata,
      ),
      body: bookList.isEmpty
          ? const Center(child: Text("No Data"))
          : RefreshIndicator(
                onRefresh: () async {
                  searchController.text = "";
                  loadBooks(title);
                },
          child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text("Book List Page $curpage/$numofpage"),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: axiscount,
                    children: List.generate(bookList.length, (index) {
                      return Card(
                        child: InkWell(
                          onTap: () async {
                            Book book = Book.fromJson(bookList[index].toJson());
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (content) => BookPage(
                                          user: widget.userdata,
                                          book: book,
                                        )));
                            loadBooks(title);
                          },
                          child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: Container(
                                  width: screenWidth,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.network(
                                      fit: BoxFit.fill,
                                      "${ServerConfig.server}/bookbytes/assets/books/${bookList[index].bookId}.png"),
                                ),
                              ),
                              Flexible(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      truncateString(
                                          bookList[index].bookTitle.toString()),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text("RM ${bookList[index].bookPrice}"),
                                    Text(
                                        "Available ${bookList[index].bookQty} unit"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: numofpage,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      //build the list for textbutton with scroll
                      if ((curpage - 1) == index) {
                        //set current page number active
                        color = Colors.red;
                      } else {
                        color = Colors.black;
                      }
                      return TextButton(
                          onPressed: () {
                            curpage = index + 1;
                            loadBooks(title);
                          },
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color, fontSize: 18),
                          ));
                    },
                  ),
                ),
              ],
            ),
        ),
    );
  }

  String truncateString(String str) {
    if (str.length > 20) {
      str = str.substring(0, 20);
      return "$str...";
    } else {
      return str;
    }
  }

  void loadBooks(String title) {
    http
        .get(
      Uri.parse(
          "${ServerConfig.server}/bookbytes/php/loadBook.php?title=$title&pageno=$curpage"),
    )
        .then((response) {
      
      if (response.statusCode == 200) {
        
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          bookList.clear();
          data['data']['books'].forEach((v) {
            bookList.add(Book.fromJson(v));
          });
          numofpage = int.parse(data['numofpage'].toString());
          numofresult = int.parse(data['numberofresult'].toString());
        } else {
          //if no status failed
        }
      }
      setState(() {});
    });
  }
}















