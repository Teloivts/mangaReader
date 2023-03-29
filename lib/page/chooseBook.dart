

import 'package:flutter/material.dart';

class MyListView extends StatefulWidget {
  final Function(int) onItemTap;
  List<String> bookshelf = [];
  MyListView(this.onItemTap,List<String> x){
    bookshelf = x;
  }

  @override
  _MyListViewState createState() => _MyListViewState(bookshelf);
}

class _MyListViewState extends State<MyListView> {
  List<String> bookshelf = [];
  _MyListViewState(List<String> x){
    bookshelf = x;
  }

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: bookshelf.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.blue,);
        },
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            widget.onItemTap(index);
            setState(() {
              if( index != _selectedIndex){
                _selectedIndex = index;
              }else{
                _selectedIndex = -1;
              }

            });
            //onItemTap(_items[index]);
          },
          child: ListTile(
            title: Text(
              bookshelf[index].split('/').last,
              style: TextStyle(
                fontWeight: index==_selectedIndex ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
