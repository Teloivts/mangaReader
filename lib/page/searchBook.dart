import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  List<String> _dataList =[];
  MyHomePage(List<String> data) {
    _dataList = data;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState(_dataList);
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _dataList = [];

  String _searchText = "";

  List<String> _searchList = [];

  _MyHomePageState(List<String> x){
    _dataList = x;
  }


  void _onSearchTextChanged(String searchText) {
    _searchList.clear();
    if (searchText.isEmpty) {
      setState(() {
        _searchText = "";
      });
      return;
    }

    _dataList.forEach((item) {
      if (item.toLowerCase().contains(searchText.toLowerCase())) {
        _searchList.add(item);
      }
    });

    setState(() {
      _searchText = searchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: _onSearchTextChanged,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _searchList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_searchList[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: Colors.blue,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

