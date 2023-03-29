import 'package:flutter/material.dart';
import '/file/localfile-manager.dart';
import 'package:my_ebook/page/readBook.dart';
import 'package:my_ebook/page/chooseBook.dart';
import 'package:my_ebook/page/searchBook.dart';
import 'dart:io';


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Swipe Navigation Demo',
      home: SwipeNavigation(),
    );
  }
}

class SwipeNavigation extends StatefulWidget {
  const SwipeNavigation({Key? key}) : super(key: key);
  //SwipeNavigation({Key key}) : super(key: key);

  @override
  _SwipeNavigationState createState() => _SwipeNavigationState();
}

class _SwipeNavigationState extends State<SwipeNavigation> {
  var temp = LocalFileManager();
  int _currentIndex = 0;
  int _currentBook = 0;
  List<String> book = [];
  List<String> bookshelf = [];
  _SwipeNavigationState(){
    init();
  }
  void myTap(int x) async{
    var temp = LocalFileManager();
    _currentBook = x;
    book = await temp.getLocalComicDetail(bookshelf[_currentBook]);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListView3(book,MediaQuery.of(context).size.height)),
      );
    print(_currentBook);
  }
  void init() async{
    bookshelf = await temp.getLocalComicDirectory();
    setState(() {

    });
  }
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe Navigation Demo'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: <Widget>[
          //ListView3(book,MediaQuery.of(context).size.height),
          MyHomePage(bookshelf),
          MyListView(myTap,bookshelf),
          Text("Waiting for you"),
          // IconButton(
          //   icon: Icon(Icons.thumb_up),
          //   onPressed: () async{
          //     // var temp = LocalFileManager();
          //
          //     // book = await temp.getLocalComicDetail(bookshelf[0]);
          //   },

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two_outlined),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3_outlined),
            label: 'Setting',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
