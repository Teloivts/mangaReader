import 'package:flutter/material.dart';
import '/file/localfile-manager.dart';
import '/page/chooseBook.dart';
import 'dart:io';
void main() => runApp(MyApp());
class ListView3 extends StatelessWidget {

  List<String> book = [];
  var heigh = 500.0;
  ListView3(List<String> x,double y){
    book = x;
    heigh = y;
  }
  @override
  Widget build(BuildContext context) {

    //下划线widget预定义以供复用。
    Widget divider1=Divider(color: Colors.blue,);
    Widget divider2=Divider(color: Colors.green);
    return ListView.separated(
      cacheExtent: heigh*10,
      itemCount: book.length,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        var num = 'http://81.68.213.251:8000/strategic-lovers-chapter-23/$index.rawkuma.com.jpg';
        num = book[index];
        //var img = Image.network(num);
        var img = Image.file(File(num));
        return img;
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return index%2==0?divider1:divider2;
      },
    );
  }

}
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
          ListView3(book,MediaQuery.of(context).size.height),

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
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two_outlined),
            label: 'More',
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
